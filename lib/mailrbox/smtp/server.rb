require "mailrbox/server"
require "mailrbox/smtp/session"

module MailRBox
  module SMTP
    class Server < MailRBox::Server

      def initialize(port = 25, options = {})
        super(port, options)
      end

      def session_class
        MailRBox::SMTP::Session
      end

    end
  end
end
