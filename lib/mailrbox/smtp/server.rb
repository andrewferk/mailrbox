require "mailrbox/server"
require "mailrbox/smtp/session"
require "mailrbox/smtp/client"

module MailRBox
  module SMTP
    class Server < MailRBox::Server

      def initialize(port = 25)
        super(port)
      end

      def init_session(client)
        Session.new(client)
      end

    end
  end
end
