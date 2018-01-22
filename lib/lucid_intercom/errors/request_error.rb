require 'lucid_intercom/errors/error'

module LucidIntercom
  class RequestError < Error
    #
    # @param status [Integer] the HTTP response status
    #
    def initialize(status)
      @status = status
    end

    # @return [Integer]
    attr_reader :status
  end
end
