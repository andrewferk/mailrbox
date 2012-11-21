require "mailrbox/server"
require "mailrbox/smtp/session"
require "mailrbox/smtp/client"

module MailRBox
  module SMTP
    class Server < MailRBox::Server

      def initialize(port = 25, options = {})
        super(port, options)
      end

      def session_class
        MailRBox::SMTP::Session
      end

      def client_class
        MailRBox::SMTP::Client
      end

    end
  end
end
