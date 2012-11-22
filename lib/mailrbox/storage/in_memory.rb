require "thread"

module MailRBox
  module Storage
    class InMemory

      def initialize
        @storage = []
      end

      def <<(content)
        @storage << content
      end

      def [](index)
        @storage[index]
      end

      def delete_at(index)
        @storage.delete_at(index)
      end

      def length
        @storage.length
      end

      def octet_size
        @storage.inject(0) {|size, mesg| size + mesg.length}
      end
    end
  end
end
