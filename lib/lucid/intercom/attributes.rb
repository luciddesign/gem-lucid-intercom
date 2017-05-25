require_relative './attributes/user'
require_relative './attributes/company'
require_relative './attributes/custom'

module Lucid
  module Intercom
    class Attributes
      attr_reader :shop_attributes, :app_attributes

      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param app_attributes [Hash] app-specific attributes (unprefixed)
      #
      def initialize(shop_attributes, app_attributes)
        @shop_attributes = shop_attributes
        @app_attributes = app_attributes
      end

      #
      # @return [Hash]
      #
      def user
        user_browser.select do |k, _|
          k != :user_hash
        end
      end

      #
      # User attributes for browser (with 'user_hash').
      #
      # @return [Hash]
      #
      def user_browser
        User.new(shop_attributes, app_attributes).()
      end

      #
      # @return [Hash]
      #
      def company
        Company.new(shop_attributes, app_attributes).()
      end

      #
      # Company attributes for browser (expects 'id', not 'company_id').
      #
      # @return [Hash]
      #
      def company_browser
        company2 = company
        company2[:id] = company2.delete(:company_id)
        company2
      end

      #
      # @return [Hash]
      #
      def custom
        Custom.new(shop_attributes, app_attributes).()
      end
    end
  end
end
