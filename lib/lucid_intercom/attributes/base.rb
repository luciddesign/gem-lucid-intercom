# frozen_string_literal: true

require 'lucid_intercom/credentials'

module LucidIntercom
  class Attributes
    class Base
      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param app_attributes [Hash] app-specific attributes (unprefixed)
      # @param credentials [LucidIntercom::Credentials]
      #
      def initialize(shop_attributes = {}, app_attributes = {}, credentials: LucidIntercom.credentials)
        @credentials = credentials
        @shop_attributes = shop_attributes
        @app_attributes = app_attributes
      end

      # @return [LucidIntercom::Credentials]
      attr_reader :credentials
      # @return [Hash]
      attr_reader :shop_attributes
      # @return [Hash]
      attr_reader :app_attributes

      #
      # @return [Hash]
      #
      def call
        normalize_values(attributes)
      end

      #
      # @return [Hash]
      #
      private def attributes
        {}
      end

      #
      # Convert attribute values to valid Intercom types.
      #
      # @param attributes [Hash]
      #
      # @return [Hash]
      #
      private def normalize_values(attributes)
        attributes.each_with_object({}) do |(k, v), a|
          v2 =
            case v
            when Integer, Float then v
            when Time then v.to_i
            when nil then nil # unset attribute
            else v.to_s
            end

          a[k] = v2
        end
      end
    end
  end
end
