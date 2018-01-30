# frozen_string_literal: true

require 'lucid_intercom/credentials'

module LucidIntercom
  module Events
    class Base
      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param credentials [LucidIntercom::Credentials]
      #
      def initialize(shop_attributes, credentials = LucidIntercom.credentials)
        @credentials = credentials
        @shop_attributes = shop_attributes
      end

      # @return [LucidIntercom::Credentials]
      attr_reader :credentials
      # @return [Hash]
      attr_reader :shop_attributes
    end
  end
end
