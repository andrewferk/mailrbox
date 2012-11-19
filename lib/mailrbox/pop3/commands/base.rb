require "mailrbox/command"

module MailRBox
  module POP3
    module Commands
      class Base < MailRBox::Command

        def response
          ""
        end

      end
    end
  end
end

