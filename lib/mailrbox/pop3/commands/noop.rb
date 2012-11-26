require "mailrbox/pop3/commands/base"

module MailRBox
  module POP3
    module Commands
      class Noop < Base
        def response
          "+OK"
        end
      end
    end
  end
end
