require "socket"
require "correspondent/smtp_session"

module Correspondent
  class SMTPServer

    attr_accessor :port

    def initialize(port = 25)
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
          SMTPSession.new(client)
        end
      end
    end

  end
end
