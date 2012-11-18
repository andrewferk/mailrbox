module MailRBox
  module SMTP
    module Commands
      class Base
        attr_accessor :arguments

        def initialize(arguments)
          @arguments = arguments
        end

        def response
          "504"
        end

        def respond(client)
          client.send_command response
        end
      end
    end
  end
end
