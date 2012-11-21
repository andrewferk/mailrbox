module MailRBox

  # An abstract Session represents a connection with a Server. A Session will
  # always be associated with a given Client.
  class Session

    # The client that initiated the session.
    attr_accessor :client
    
    attr_accessor :storage

    # Initialize the Session by wrapping the current Ruby TCPSocket
    # representation of the client in a domain Client, completing the
    # handshake process with the client, and begin listening for messages
    # from the client.
    def initialize(client, storage)
      @client = client
      @storage = storage
      handshake
      init_message_listener
    end

    # Send a command to the Client, ensuring it is terminated with a <CRLF>.
    def send_command(command)
      @client.write "#{command}\r\n"
    end

    # Close the session and connection with the Client.
    def close
      @client.close
    end

    private

    # Complete session initialization with the client by stepping through the
    # handshake process. While this is optional to override, it is expected
    # that the protocol will have a required handshake protocol.
    def handshake
    end

    # The defined concrete CommandFactory class to use when creating a new
    # Command. This is required and must be overridden when creating a
    # concrete Session.
    def command_factory
    end

    # Listen for messages from the client, and delegate message
    # initialization, at least until the client's session has closed.
    def init_message_listener
      begin
        message = @client.gets
        init_message(message)
      end until @client.closed?
    end

    # When the client sends a new message, use a CommandFactory to determine
    # the command delivered in the message, and then delegate response and
    # action to the Command.
    def init_message(message)
      command = command_factory.instance.build(message)
      command.respond(self)
    end

  end
end
