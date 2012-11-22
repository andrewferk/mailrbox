require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class Retr < Base
        def respond(session)
          index = @arguments.to_i - 1
          store = session.storage
          msg = "+OK #{store[index].length} octets\r\n"
          msg << store[index]
          msg << "."
          session.send_command msg
        end
      end
    end
  end
end
