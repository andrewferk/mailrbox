require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class Dele < Base
        def respond(session)
          index = @arguments.to_i - 1
          session.storage.delete_at(index)
          session.send_command "+OK message #{index + 1} deleted"
        end
      end
    end
  end
end
