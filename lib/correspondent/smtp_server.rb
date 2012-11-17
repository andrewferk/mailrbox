require "socket"

module Correspondent
  class SMTPServer
    def initialize(port = 25)
      @server = TCPServer.open(port)
      loop do
        Thread.start(@server.accept) do |client|
          begin
            client.write "220 localhost andrewferk/correspondent mail server\r\n"
            begin
              input = client.gets
              command = input.match(/^[^\s]+/).to_s
              case command
                when 'EHLO', 'HELO'
                  client.write "250 Hello\r\n"
                when "QUIT"
                  client.write "221 Bye\r\n"
                  client.close
                else
                  puts "else -> '#{input}'"
              end
            end until client.closed?
          rescue Exception => e
            puts "Exception occured: " + e.message
          end
        end
      end
    end
  end
end
