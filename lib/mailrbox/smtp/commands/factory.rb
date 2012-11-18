require "singleton"
require "mailrbox/smtp/commands/ehlo"
require "mailrbox/smtp/commands/helo"
require "mailrbox/smtp/commands/quit"

module MailRBox
  module SMTP
    module Commands
      class Factory
        include Singleton

        COMMANDS = {
          :ehlo => Ehlo,
          :helo => Helo,
          :quit => Quit
        }

        # Parse a message for the command, and build an object
        # of the command type.
        def build(message)

          # The first word in the message should be the command, and the
          # remaining is the command's arguments
          command, arguments = message.split(/\s/, 2)

          COMMANDS[command.downcase.to_sym].new(arguments)
        end
      end
    end
  end
end
