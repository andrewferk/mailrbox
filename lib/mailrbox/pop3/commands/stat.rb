require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class Stat < Base
        def respond(session)
          store = session.storage
          session.send_command "+OK #{store.length} #{store.octet_size}"
        end
      end
    end
  end
end
