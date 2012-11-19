require "singleton"

module MailRBox
  class CommandFactory
    include Singleton

    COMMANDS = {}

    # Parse a message for the command, and build an object
    # of the command type.
    def build(message)

      # The first word in the message should be the command, and the
      # remaining is the command's arguments
      command, arguments = message.split(/\s/, 2)

      klass = self.class::COMMANDS[command.downcase.to_sym]
      klass.new(arguments)
    end
  end
end
