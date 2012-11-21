require "mailrbox/session"
require "mailrbox/smtp/commands/factory"

module MailRBox
  module SMTP
    class Session < MailRBox::Session

      # Session Initiation
      # http://tools.ietf.org/html/rfc5321#section-3.1
      def handshake
        send_command("220")
      end

      def command_factory
        MailRBox::SMTP::Commands::Factory
      end

    end
  end
end
