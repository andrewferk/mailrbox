require 'socket'

module MailRBox
  module ConnectListeners
    def start_connect_listener
      @threaded_listener = Thread.new do
        loop do
          Thread.start(@server.accept) do |socket|
            init_session(socket)
          end
        end
      end
    end

    def stop_connect_listener
      Thread.kill(@threaded_listener)
    end
  end
end
