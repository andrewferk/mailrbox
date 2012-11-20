require "delegate"

module MailRBox

  # An abstract Client that wraps functionality around a TCPSocket. All
  # functionality provided by a TCPSocket is provide through Client by means
  # of SimpleDelegator. Wrapping has been utilized to provide domain
  # consistency and future expansion of the Client.
  class Client < SimpleDelegator
  end

end
