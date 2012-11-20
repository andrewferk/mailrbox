require "mailrbox/command_factory"
require "mailrbox/pop3/commands/user"
require "mailrbox/pop3/commands/pass"
require "mailrbox/pop3/commands/quit"
require "mailrbox/pop3/commands/stat"

module MailRBox
  module POP3
    module Commands
      class Factory < MailRBox::CommandFactory
        def commands
          {
            :user => User,
            :pass => Pass,
            :quit => Quit,
            :stat => Stat
          }
        end
      end
    end
  end
end
