require "mailrbox/smtp/commands/base"

module MailRBox
  module SMTP
    module Commands
      class Quit < Base
        def response
          "221 Bye"
        end

        def respond(client)
          super(client)
          client.close
        end
      end
    end
  end
end

