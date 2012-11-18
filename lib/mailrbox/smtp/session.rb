require "mailrbox/smtp/client"
require "mailrbox/smtp/commands/factory"

module MailRBox
  module SMTP
    class Session

      attr_accessor :client

      def initialize(client)
        @client = Client.new(client)
        initiate_session
        init_command_listener
      end

      # Session Initiation
      # http://tools.ietf.org/html/rfc5321#section-3.1
      def initiate_session
        @client.send_command("220")
      end

      # Listen for messages from the client, and delegate response,
      # until the client's session has closed.
      def init_command_listener
        begin
          message = @client.gets
          command = MailRBox::SMTP::Commands::Factory.instance.build(message)
          command.respond(@client)
        end until @client.closed?
      end

    end
  end
end
