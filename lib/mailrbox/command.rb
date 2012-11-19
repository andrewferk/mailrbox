module MailRBox
  class Command
    attr_accessor :arguments

    def initialize(arguments)
      @arguments = arguments
    end

    def response
    end

    def respond(session)
      session.send_command response
    end

  end
end
