$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "minitest/autorun"
require 'mailrbox'

SMTP_PORT = 2500
POP_PORT = 1100
@@mailrbox = nil

class MiniTestWithHooksUnit < MiniTest::Unit
  def before_suites
    # Create a new subprocess, and start the Servers
    @proc = fork do
      mailrbox = MailRBox.single_process_blocking_build({
        :smtp_port => SMTP_PORT,
        :pop3_port => POP_PORT,
        :smtp_backlog => 100
      })
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
