require "mailrbox/command_factory"
require "mailrbox/smtp/commands/ehlo"
require "mailrbox/smtp/commands/helo"
require "mailrbox/smtp/commands/quit"
require "mailrbox/smtp/commands/mail"
require "mailrbox/smtp/commands/rcpt"
require "mailrbox/smtp/commands/data"
require "mailrbox/smtp/commands/base"

module MailRBox
  module SMTP
    module Commands
      class Factory < MailRBox::CommandFactory
        def commands
          {
            :ehlo => Ehlo,
            :helo => Helo,
            :quit => Quit,
            :mail => Mail,
            :rcpt => Rcpt,
            :data => Data
          }
        end
      end
    end
  end
end
