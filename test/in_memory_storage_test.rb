require File.dirname(File.expand_path(__FILE__)) + '/helper'
require "mailrbox/storage/in_memory"
require "mailrbox/pool"

class InMemoryStorageTest < MiniTest::Unit::TestCase

  def setup
    @storage = MailRBox::Storage::InMemory.new
    @contents = []
    @contents << "123"
    @contents << "456"
    @contents << "789"
  end

  def test_add_content
    @storage << @contents[0]
    assert_equal(1, @storage.length)
  end

  def test_get_content
    @storage << @contents[0]
    assert_equal(@contents[0], @storage[0])
  end

  def test_delete_at_content
    @storage << @contents[0]
    @storage << @contents[1]
    @storage << @contents[2]
    @storage.delete_at(1)
    assert_equal(2, @storage.length)
    assert_equal(@contents[0], @storage[0])
    assert_equal(@contents[2], @storage[1])
  end

end
