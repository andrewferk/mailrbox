require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class List < Base
        def respond(session)
          store = session.storage
          msg = "+OK #{store.length} messages (#{store.octet_size} octets)\r\n"
          i = 0
          while store[i] do
            msg << "#{i + 1} #{store[i].length}\r\n"
            i += 1
          end
          msg << "."
          session.send_command msg
        end
      end
    end
  end
end
