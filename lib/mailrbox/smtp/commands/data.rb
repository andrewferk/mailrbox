require "mailrbox/smtp/commands/base"

module MailRBox
  module SMTP
    module Commands
      class Data < Base
        def response
          "354 End data with <CR><LF>.<CR><LF>"
        end

        def content_response
          "250 Ok"
        end

        def respond(session)
          super(session)
          content = get_content(session.client)
          session.send_command content_response
        end

        def get_content(client)
          content = ""
          terminate = false
          begin
            message = client.gets
            if message == ".\r\n"
              terminate = true
            else
              content << message
            end
          end until terminate
          return content
        end
      end

    end
  end
end
