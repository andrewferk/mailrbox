require "socket"

module MailRBox
  class Server

    attr_accessor :port

    def initialize(port)
      @port = port
      init_transport_listener
      init_application_listener
    end

    def init_transport_listener
      @server = TCPServer.open(@port)
    end

    def init_application_listener
      loop do
        Thread.start(@server.accept) do |client|
          init_session(client)
        end
      end
    end

    def init_session(client)
    end

  end
end
