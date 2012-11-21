require 'mailrbox/pop3/server'
require 'mailrbox/smtp/server'
require 'mailrbox/storage/in_memory'

module MailRBox
  def self.single_process_blocking_build(options = {})

    @smtp_port    = options[:smtp_port] || 25
    @pop3_port    = options[:pop3_port] || 110
    @smtp_backlog = options[:smtp_backlog] || 20
    @pop3_backlog = options[:pop3_backlog] || 10

    @storage = MailRBox::Storage::InMemory.new

    @smtp_server = MailRBox::SMTP::Server.new(
      @smtp_port, {:backlog => @smtp_backlog, :storage => @storage})
    @smtp_server.start

    @pop3_server = MailRBox::POP3::Server.new(
      @pop3_port, {:backlog => @pop3_backlog, :storage => @storage})
    @pop3_server.start

    begin
      loop { sleep 5 }
    rescue Interrupt => e
      smtp_server.stop
      pop3_server.stop
    end
  end

  def self.smtp_server
    @smtp_server
  end

  def self.pop3_server
    @pop3_server
  end
end
