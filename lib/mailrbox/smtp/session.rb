require "mailrbox/session"
require "mailrbox/smtp/commands/factory"

module MailRBox
  module SMTP
    class Session < MailRBox::Session

      # Session Initiation
      # http://tools.ietf.org/html/rfc5321#section-3.1
      def initiate_session
        send_command("220")
      end

      def command_factory
        MailRBox::SMTP::Commands::Factory
      end

      def client_class
        MailRBox::SMTP::Client
      end

    end
  end
end
