require "mailrbox/server"
require "mailrbox/pop3/session"
require "mailrbox/pop3/client"

module MailRBox
  module POP3
    class Server < MailRBox::Server

      def initialize(port = 110, options = {})
        super(port, options)
      end

      def session_class
        MailRBox::POP3::Session
      end

      def client_class
        MailRBox::POP3::Client
      end

    end
  end
end
