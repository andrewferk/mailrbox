require File.dirname(File.expand_path(__FILE__)) + '/helper'
require "mailrbox/email"

class EmailTest < MiniTest::Unit::TestCase

  def setup
    @header = "From: test@example.com\r\n" +
      "To: andrewferk@gmail.com\r\n" +
      "Subject: Hi Andrew"
    @body = "Body line 1.\r\n" +
      "Body line 2.\r\n" +
      "Body line 3.\r\n" +
      "Body line 4."
    @message = "#{@header}\r\n\r\n#{@body}"
    @email = MailRBox::Email.new(@message)
  end

  def test_header
    assert_equal(@header, @email.header)
  end

  def test_body_with_default
    assert_equal(@body, @email.body)
  end

  def test_body_with_zero
    assert_equal(nil, @email.body(0))
  end

  def test_body_with_one
    assert_equal("Body line 1.", @email.body(1))
  end

  def test_body_with_two
    assert_equal("Body line 1.\r\nBody line 2.", @email.body(2))
  end

end
