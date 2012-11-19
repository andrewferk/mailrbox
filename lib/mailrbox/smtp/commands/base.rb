require "mailrbox/command"

module MailRBox
  module SMTP
    module Commands
      class Base < MailRBox::Command

        def response
          "504"
        end

      end
    end
  end
end
