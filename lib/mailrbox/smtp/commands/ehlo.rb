require "mailrbox/smtp/commands/base"

module MailRBox
  module SMTP
    module Commands
      class Ehlo < Base
        def response
          "250 Hello"
        end
      end
    end
  end
end
