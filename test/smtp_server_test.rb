require File.dirname(File.expand_path(__FILE__)) + '/helper'
require "net/smtp"

class SMTPServerTest < MiniTest::Unit::TestCase

  def test_connection_to_smtp_server
    Net::SMTP.start('localhost', SMTP_PORT) do |smtp|
      assert smtp.is_a? Net::SMTP
    end
  end

  def test_send_message_through_smtp_server
    smtp = Net::SMTP.new('localhost', SMTP_PORT)
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
