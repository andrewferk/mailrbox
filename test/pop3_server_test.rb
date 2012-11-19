require File.dirname(File.expand_path(__FILE__)) + '/helper'
require 'net/pop'

class POP3ServerTest < MiniTest::Unit::TestCase

  def test_connection_to_pop3_server
    pop = Net::POP3.start('localhost', POP_PORT, 'dummy', 'dummmy') do |pop|
      assert pop.is_a? Net::POP3
    end
  end

end
