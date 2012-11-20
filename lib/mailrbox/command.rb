module MailRBox

  # An abstract Command that responds and takes action on behalf of a Session.
  class Command

    # Arguments from the message the requested the Command's action.
    attr_accessor :arguments

    # Initialize the Command by assigning the arguments.
    def initialize(arguments)
      @arguments = arguments
    end

    # By default, respond to a given message by sending a response
    def respond(session)
      session.send_command response
    end

    private

    # The response to send. Unless respond is overridden, response is required
    # and must be overridden when creating a concrete Command.
    def response
    end

  end
end
