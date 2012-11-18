require "delegate"

module MailRBox
  module SMTP
    class Client < SimpleDelegator

      # Send a command to the client, ensuring it is terminated with a <CRLF>.
      def send_command(command)
        write "#{command}\r\n"
      end

    end
  end
end
