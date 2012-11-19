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
      smtp_server = MailRBox::SMTP::Server.new(SMTP_PORT)
    end

    # Create a new subprocess, and start the POP3 Server
    @pop3_proc = fork do
      pop3_server = MailRBox::POP3::Server.new(POP_PORT)
    end
  end

  def after_suites
    # Kill the SMTP Server
    Process.kill("TERM", @smtp_proc)

    # Kill the POP3 Server
    Process.kill("TERM", @pop3_proc)
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
