$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)), '..', 'lib')
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "minitest/autorun"
require "net/smtp"

PORT = 2500

class MiniTestWithHooksUnit < MiniTest::Unit
  def before_suites
    # Create a new subprocess, and start the SMTP Server
    @smtp_proc = fork do
      server = MailRBox::SMTP::Server.new(PORT);
    end
  end

  def after_suites
    # Kill the SMTP Server
    Process.kill("TERM", @smtp_proc)
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
