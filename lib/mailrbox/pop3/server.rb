require "mailrbox/server"
require "mailrbox/pop3/session"
require "mailrbox/pop3/client"

module MailRBox
  module POP3
    class Server < MailRBox::Server

      def initialize(port = 110)
        super(port)
      end

      def init_session(client)
        Session.new(client)
      end

    end
  end
end
