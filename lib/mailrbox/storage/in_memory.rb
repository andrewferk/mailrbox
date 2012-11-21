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
    end
  end
end
