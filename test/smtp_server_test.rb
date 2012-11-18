require File.dirname(File.expand_path(__FILE__)) + '/helper'
require 'mailrbox'

class SMTPServerTest < Test::Unit::TestCase

  PORT = 2500

  def setup
    # Create a new subprocess, and start the SMTP Server
    @smtp_proc = fork do
      server = MailRBox::SMTP::Server.new(PORT);
    end
  end

  def teardown
    # Kill the SMTP Server
    Process.kill("TERM", @smtp_proc)
  end

  def test_connection_to_smtp_server
    Net::SMTP.start('localhost', PORT) do |smtp|
      assert smtp.is_a? Net::SMTP
    end
  end

  def test_send_message_through_smtp_server
    skip
    smtp = Net::SMTP.new('localhost', PORT)
    smtp.start do |smtp|
      message = "From: test@example.com\r\n" +
        "To: andrewferk@gmail.com\r\n" +
        "Subject: Hi Andrew\r\n\r\n" +
        "This is the body.\r\n"
      smtp.send_message(message, "test@example.com", "andrewferk@gmail.com")
    end
    assert smtp.is_a? Net::SMTP
  end

end
