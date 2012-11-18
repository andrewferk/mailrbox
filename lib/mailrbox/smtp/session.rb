require "mailrbox/smtp/client"
require "mailrbox/smtp/commands/factory"

module MailRBox
  module SMTP
    class Session

      attr_accessor :client

      def initialize(client)
        @client = Client.new(client)
        initiate_session
        init_transport_listener
      end

      # Session Initiation
      # http://tools.ietf.org/html/rfc5321#section-3.1
      def initiate_session
        send_command("220")
      end

      # Listen for messages from the client, and delegate response,
      # until the client's session has closed.
      def init_transport_listener
        begin
          message = @client.gets
          command = MailRBox::SMTP::Commands::Factory.instance.build(message)
          command.respond(self)
        end until @client.closed?
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
end
