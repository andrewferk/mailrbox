require File.dirname(File.expand_path(__FILE__)) + '/helper'
require "net/smtp"
require "mailrbox/pool"
require "timeout"

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

  def test_non_blocking
    error = false
    begin
      Timeout::timeout(1) do
        smtp_server = MailRBox::SMTP::Server.new(12345)
        smtp_server.start
        smtp_server.stop
        completed = true
      end
    rescue
      error = true
    end

    assert !error
  end

  def test_smtp_server_concurrency
    proc1 = fork do
      concurrency_helper
    end

    proc2 = fork do
      concurrency_helper
    end

    Process.wait(proc1)
    Process.wait(proc2)
  end

  def concurrency_helper
    pool = Pool.new(40)
    1000.times do |i|
      pool.schedule do
        Net::SMTP.start('localhost', SMTP_PORT) do |smtp|
          assert smtp.is_a? Net::SMTP
        end
      end
    end

    at_exit { pool.shutdown }
  end

end
