require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class Quit < Base
        def response
          "+OK"
        end

        def respond(session)
          super(session)
          session.close
        end
      end
    end
  end
end


