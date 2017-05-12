module Lucid
  module Intercom
    module Events
      class Base
        attr_reader :shop_attributes

        #
        # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
        #
        def initialize(shop_attributes)
          @shop_attributes = shop_attributes
        end
      end
    end
  end
end
