require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class Stat < Base
        def response
          "+OK 0 0"
        end
      end
    end
  end
end
