require_relative '../../intercom'

module Lucid
  module Intercom
    module Events
      class Base
        attr_reader :shop_attributes
        attr_reader :credentials

        #
        # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
        # @param credentials [Lucid::Intercom::Credentials]
        #
        def initialize(shop_attributes, credentials: nil)
          @credentials = credentials || Lucid::Intercom.credentials

          @shop_attributes = shop_attributes
        end
      end
    end
  end
end
