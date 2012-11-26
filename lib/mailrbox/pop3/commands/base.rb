require "mailrbox/command"

module MailRBox
  module POP3
    module Commands
      class Base < MailRBox::Command

        def response
          "-ERR"
        end

      end
    end
  end
end

