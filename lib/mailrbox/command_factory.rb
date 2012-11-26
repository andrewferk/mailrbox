require "singleton"

module MailRBox

  # An abstract CommandFactory that has a purpose of parsing the client's
  # message to determine which Command to create.
  class CommandFactory

    # The CommandFactory is a singleton, as there is no need for multiple
    # instantiations.
    include Singleton

    # Parse a message to determine the command, and build an object
    # of the Command type.
    def build(message)

      # The first word in the message should be the command, and the
      # remaining is the command's arguments
      command, arguments = message.split(/\s/, 2)

      # Lookup the command and create it with any remaining arguments from the
      # message
      klass = commands[command.downcase.to_sym] || base
      klass.new(arguments)
    end

    private

    # The defined hash of command symbols to command Class for lookup. This is
    # required and must be overridden when creating a concrete CommandFactory.
    def commands
    end

    def base
    end

  end
end
