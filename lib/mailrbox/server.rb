require "socket"
require "mailrbox/connect_listeners/threaded_listener"

module MailRBox

  # An abstract Server that uses the TCP transport protocol to listen to a
  # given port, and then accept connections. When a connection is accepted,
  # a new Session is created, along with having the Client passed along.
  class Server
    include ConnectListeners

    # Initialize the Server by assigning the port, and initializing transport
    # protocol and connection listeners.
    def initialize(port, options = {})
      @port = port
      @backlog = options[:backlog] || 20
    end

    def start
      init_transport_listener
      init_connect_listener
    end

    def stop
      stop_connect_listener
    end

    private

    # The defined concrete Session class to use when creating a new Session.
    # This is required and must be overridden when creating a concrete Server.
    def session_class
    end

    # Begin listening to the given port using the TCP transport protocol.
    def init_transport_listener
      @server = TCPServer.open(@port)
      @server.listen @backlog
    end

    # Begin listening to new connections, and delegating session
    # initialization
    def init_connect_listener
      start_connect_listener
    end

    # When a new connection occurs, initialize a new Session with the client,
    # which is still a Ruby TCPSocket.
    def init_session(client)
      session_class.new(client)
    end

  end
end
