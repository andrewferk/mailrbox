require "mailrbox/command_factory"
require "mailrbox/pop3/commands/base"
require "mailrbox/pop3/commands/user"
require "mailrbox/pop3/commands/pass"
require "mailrbox/pop3/commands/quit"
require "mailrbox/pop3/commands/stat"
require "mailrbox/pop3/commands/list"
require "mailrbox/pop3/commands/retr"
require "mailrbox/pop3/commands/dele"
require "mailrbox/pop3/commands/capa"
require "mailrbox/pop3/commands/top"

module MailRBox
  module POP3
    module Commands
      class Factory < MailRBox::CommandFactory
        def commands
          {
            :user => User,
            :pass => Pass,
            :quit => Quit,
            :stat => Stat,
            :list => List,
            :retr => Retr,
            :dele => Dele,
            :capa => Capa,
            :top  => Top
          }
        end

        def base
          MailRBox::POP3::Commands::Base
        end
      end
    end
  end
end
