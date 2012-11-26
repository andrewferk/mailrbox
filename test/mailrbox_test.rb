require File.dirname(File.expand_path(__FILE__)) + '/helper'
require "net/smtp"
require "net/pop"

class MailRBoxTest < MiniTest::Unit::TestCase

  def setup
    @storage = MailRBox::Storage::InMemory.new
    @smtp_server = MailRBox::SMTP::Server.new(
      9999, {:backlog => 20, :storage => @storage})
    @pop3_server = MailRBox::POP3::Server.new(
      7777, {:backlog => 5, :storage => @storage})
    @smtp_server.start
    @pop3_server.start
    @message = "From: test@example.com\r\n" +
      "To: andrewferk@gmail.com\r\n" +
      "Subject: Hi Andrew\r\n\r\n" +
      "This is the body.\r\n"
  end

  def teardown
    @smtp_server.stop
    @pop3_server.stop
  end

  def test_mailrbox_storage
    msg = nil
    smtp = Net::SMTP.new('localhost', 9999)
    smtp.start do |smtp|
      smtp.send_message(@message, "test@example.com", "andrewferk@gmail.com")
    end
    assert_equal(1, @storage.length)
    pop = Net::POP3.start('localhost', 7777, 'dummy', 'dummmy') do |pop|
      mail = pop.mails[0]
      msg = mail.pop
      mail.delete
    end
    assert_equal(0, @storage.length)
    assert_equal(msg, @message)
  end

  def test_pop_top
    @message[0] << "And another line\r\n"
    @storage << @message
  end
  
end
