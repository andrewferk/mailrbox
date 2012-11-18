require "singleton"
require "mailrbox/smtp/commands/ehlo"
require "mailrbox/smtp/commands/helo"
require "mailrbox/smtp/commands/quit"
require "mailrbox/smtp/commands/mail"
require "mailrbox/smtp/commands/rcpt"
require "mailrbox/smtp/commands/data"
require "mailrbox/smtp/commands/base"

module MailRBox
  module SMTP
    module Commands
      class Factory
        include Singleton

        COMMANDS = {
          :ehlo => Ehlo,
          :helo => Helo,
          :quit => Quit,
          :mail => Mail,
          :rcpt => Rcpt,
          :data => Data
        }

        # Parse a message for the command, and build an object
        # of the command type.
        def build(message)

          # The first word in the message should be the command, and the
          # remaining is the command's arguments
          command, arguments = message.split(/\s/, 2)

          klass = COMMANDS[command.downcase.to_sym]
          if klass
            builder = klass.new(arguments)
          else
            builder = MailRBox::SMTP::Commands::Base.new(arguments)
          end

          return builder
        end
      end
    end
  end
end
