require File.dirname(File.expand_path(__FILE__)) + '/helper'
require 'correspondent'

class SMTPServerTest < Test::Unit::TestCase

  def test_smtp

    smtp_proc = fork do
      server = Correspondent::SMTPServer.new(2500)
    end

    begin
      Net::SMTP.start('localhost', 2500) do |smtp|
        assert smtp.is_a? Net::SMTP
      end
    rescue Exception => e
      puts "Exception occured: " + e.message
    end

    Process.kill("TERM", smtp_proc)

  end

end
