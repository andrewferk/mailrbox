require "mailrbox/smtp/commands/base"

module MailRBox
  module SMTP
    module Commands
      class Rcpt < Base
        def response
          "250 Ok"
        end
      end
    end
  end
end
