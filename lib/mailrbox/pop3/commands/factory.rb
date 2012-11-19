require "mailrbox/command_factory"
require "mailrbox/pop3/commands/user"
require "mailrbox/pop3/commands/pass"
require "mailrbox/pop3/commands/quit"

module MailRBox
  module POP3
    module Commands
      class Factory < MailRBox::CommandFactory

        COMMANDS = {
          :user => User,
          :pass => Pass,
          :quit => Quit
        }

      end
    end
  end
end
