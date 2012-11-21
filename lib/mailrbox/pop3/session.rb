require "mailrbox/session"
require "mailrbox/pop3/commands/factory"

module MailRBox
  module POP3
    class Session < MailRBox::Session

      def handshake
        send_command("+OK")
      end

      def command_factory
        MailRBox::POP3::Commands::Factory
      end

    end

  end
end
