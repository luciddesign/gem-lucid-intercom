# frozen_string_literal: true

require 'dry-initializer'

require 'lucid_intercom/convert'

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
    def to_h(convert: Convert.new)
      convert.({})
    end
  end
end
