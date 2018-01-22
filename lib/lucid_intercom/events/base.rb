require_relative '../credentials'

module LucidIntercom
  module Events
    class Base
      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param credentials [LucidIntercom::Credentials]
      #
      def initialize(shop_attributes, credentials: nil)
        @credentials = credentials || LucidIntercom.credentials

        @shop_attributes = shop_attributes
      end

      attr_reader :shop_attributes
      attr_reader :credentials
    end
  end
end
