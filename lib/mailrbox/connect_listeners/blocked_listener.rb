require "thread"

module MailRBox
  module ConnectListeners

    # This is blocking
    def start_connect_listener
      loop do
        Thread.start(@server.accept) do |client|
          init_session(client)
        end
      end
    end

    # Never really get here
    def stop_connect_listener
    end
  end
end
