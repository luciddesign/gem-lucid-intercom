# frozen_string_literal: true

require 'lucid_intercom/container'

module LucidIntercom
  class Attributes
    extend Dry::Initializer

    # @return [Hash] shop attributes as returned by the Shopify API
    param :shopify_data, reader: :private
    # @return [Hash] app attributes (unprefixed)
    param :app_data, reader: :private, default: -> { {} }

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
