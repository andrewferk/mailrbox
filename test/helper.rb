$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)), '..', 'lib')
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "minitest/autorun"
require 'mailrbox'

SMTP_PORT = 2500
POP_PORT = 1100

class MiniTestWithHooksUnit < MiniTest::Unit
  def before_suites
    # Create a new subprocess, and start the Servers
    @proc = fork do
      smtp_server = MailRBox::SMTP::Server.new(SMTP_PORT, {:backlog => 100})
      smtp_server.start
      pop3_server = MailRBox::POP3::Server.new(POP_PORT, {:backlog => 100})
      pop3_server.start
      begin
        loop { sleep 5 }
      rescue Interrupt => e
        smtp_server.stop
        pop3_server.stop
      end
    end
  end

  def after_suites
    # Kill the Servers
    Process.kill("INT", @proc)

    # Wait for Servers to stop
    Process.wait(@proc)
  end

  def _run_suites(suites, type)
    begin
      before_suites
      super(suites, type)
    ensure
      after_suites
    end
  end
end

MiniTest::Unit.runner = MiniTestWithHooksUnit.new
