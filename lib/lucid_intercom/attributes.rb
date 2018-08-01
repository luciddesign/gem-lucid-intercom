# frozen_string_literal: true

require 'lucid_intercom/container'

module LucidIntercom
  class Attributes
    extend Dry::Initializer

    # @return [Hash] shop attributes as returned by the Shopify API
    param :shopify_data, reader: :private

    #
    # @abstract
    #
    # @param convert [#call]
    #
    # @return [Hash]
    #
    def to_h(convert: Container[:convert])
      convert.({})
    end
  end
end
