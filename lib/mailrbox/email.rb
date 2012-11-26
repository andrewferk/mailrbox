require "delegate"

module MailRBox
  class Email < SimpleDelegator
    def header
      self.split("\r\n\r\n", 2)[0]
    end

    def body(length = -1)
      bdy = self.split("\r\n\r\n", 2)[1]
      if (length === -1)
        return bdy
      elsif (length === 0)
        return nil
      elsif (length > 0)
        bdy.split("\r\n")[0,length].join("\r\n")
      end
    end
  end
end
