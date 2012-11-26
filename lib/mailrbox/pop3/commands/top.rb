require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class Top < Base
        def respond(session)
          index, body_length = @arguments.split(" ")
          index = index.to_i - 1
          body_length = body_length.to_i
          store = session.storage
          msg = "+OK\r\n"
          msg << store[index].header + "\r\n\r\n"
          if (body_length > 0)
            msg << store[index].body(body_length)
          end
          msg << "\r\n."
          session.send_command msg
        end
      end
    end
  end
end
