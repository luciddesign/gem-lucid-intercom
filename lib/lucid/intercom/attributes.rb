require_relative '../intercom'

module Lucid
  class Intercom
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
      # Standard Intercom user attributes.
      #
      def user
        normalize(
          # NOTE: currently unused # user_hash: '',
          # NOTE: currently unused # user_id: shop_attributes['myshopify_domain'],
          email: shop_attributes['email'],
          name: shop_attributes['shop_owner']
        )
      end

      #
      # Convert values to valid Intercom types.
      #
      private def normalize(attributes)
        attributes.each_with_object({}) do |(k, v), attributes2|
          v2 = case v
          when Time then v.to_i
          when Integer, Float then v
          else v.to_s
          end

          attributes2[k] = v2
        end
      end

      #
      # Standard Intercom company attributes.
      #
      def company
        normalize(
          company_id: shop_attributes['myshopify_domain'],
          name: shop_attributes['name']
        )
      end

      def custom
        normalize(
          custom_shopify.merge(custom_app)
        )
      end

      #
      # These custom attributes are prefixed with 'merchant_' to distinguish
      # from the Shopify intergration's 'shopify_' prefix.
      #
      private def custom_shopify
        {
          merchant_domain: shop_attributes['domain'],
          merchant_myshopify_domain: shop_attributes['myshopify_domain'],
          merchant_shop_owner: shop_attributes['shop_owner'],
          merchant_timezone: shop_attributes['timezone']
        }
      end

      #
      # Anything app-specific.
      #
      private def custom_app
        app_attributes.each_with_object({}) do |(k, v), attributes|
          attributes["#{Lucid::Intercom::APP_PREFIX}_#{k}"] = v
        end
      end
    end
  end
end
