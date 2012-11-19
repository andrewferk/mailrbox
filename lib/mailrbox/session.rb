module MailRBox
  class Session

    attr_accessor :client

    def initialize(client)
      @client = client_class.new(client)
      initiate_session
      init_transport_listener
    end

    def initiate_session
    end

    # Listen for messages from the client, and delegate response,
    # until the client's session has closed.
    def init_transport_listener
      begin
        message = @client.gets
        init_message(message)
      end until @client.closed?
    end

    def init_message(message)
      command = command_factory.instance.build(message)
      command.respond(self)
    end

    def command_factory
    end

    def client_class
    end

    # Send a command to the client, ensuring it is terminated with a <CRLF>.
    def send_command(command)
      @client.write "#{command}\r\n"
    end

    def close
      @client.close
    end

  end
end
