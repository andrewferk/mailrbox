module MailRBox
  module SMTP
    class Session

      attr_accessor :client

      def initialize(client)
        @client = client
        initiate_session
        init_command_listener
      end

      # Session Initiation
      # http://tools.ietf.org/html/rfc5321#section-3.1
      def initiate_session
        send_command "220"
      end

      # Listen for messages from the client, and parse the command and dispatch,
      # until the client's session has closed.
      def init_command_listener
        begin
          # Receive a message from the client
          message = client.gets

          # The first word in the message should be the command, and the
          # remaining is the command's arguments
          command, arguments = message.split(/\s/, 2)

          send("on_command_#{command.downcase}".to_sym, arguments)
        end until client.closed?
      end

      def on_command_ehlo(args)
        send_command "250 Hello"
      end

      def on_command_helo(args)
        on_command_ehlo(args)
      end

      def on_command_quit(args)
        send_command "221 Bye"
        @client.close
      end

      # Send a command to the client, ensuring it is terminated with a <CRLF>.
      def send_command(command)
        @client.write "#{command}\r\n"
      end

    end
  end
end
