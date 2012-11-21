$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)), '..', 'lib')
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "minitest/autorun"
require 'mailrbox'

SMTP_PORT = 2500
POP_PORT = 1100

class MiniTestWithHooksUnit < MiniTest::Unit
  def before_suites
    # Create a new subprocess, and start the SMTP Server
    @smtp_proc = fork do
      smtp_server = MailRBox::SMTP::Server.new(SMTP_PORT, {:backlog => 100})
      smtp_server.start
      awake = true
      Signal.trap("TERM") do
        smtp_server.stop
        awake = false
      end
      begin
        sleep 0.1
      end while awake
    end

    # Create a new subprocess, and start the POP3 Server
    @pop3_proc = fork do
      pop3_server = MailRBox::POP3::Server.new(POP_PORT, {:backlog => 100})
      pop3_server.start
      awake = true
      Signal.trap("TERM") do
        pop3_server.stop
        awake = false
      end
      begin
        sleep 0.1
      end while awake
    end
  end

  def after_suites
    # Kill the Servers
    Process.kill("TERM", @smtp_proc)
    Process.kill("TERM", @pop3_proc)

    # Wait for Servers to stop
    Process.wait(@smtp_proc)
    Process.wait(@pop3_proc)
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
