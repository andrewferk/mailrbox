require "mailrbox/server"
require "mailrbox/pop3/session"

module MailRBox
  module POP3
    class Server < MailRBox::Server

      def initialize(port = 110)
        super(port)
      end

      def session_class
        MailRBox::POP3::Session
      end

    end
  end
end
