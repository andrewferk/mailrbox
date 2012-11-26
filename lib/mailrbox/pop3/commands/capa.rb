require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class Capa < Base
        def respond(session)
          msg = "+OK\r\n"
          msg << "CAPA\r\n"
          msg << "USER\r\n"
          msg << "."
          session.send_command msg
        end
      end
    end
  end
end
