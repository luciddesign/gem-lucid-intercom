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
      # Attributes structured for API requests. Custom attributes are nested.
      #
      # @return [Hash]
      #
      def for_api
        a = attributes.merge(custom_attributes: custom_attributes)

        normalize(a)
      end

      #
      # Attributes structured for browser snippet. Values are escaped.
      #
      # @return [Hash]
      #
      def for_browser
        a = attributes.merge(custom_attributes)

        normalize(a)
      end

      alias_method :call, :for_api

      private def normalize(a)
        a.each_with_object({}) do |(k, v), h|
          h[k] = case v
          when Hash then normalize(v)
          when Time then v.to_i
          when Integer, Float then v
          else v.to_s
          end
        end
      end

      #
      # Standard Intercom attributes.
      #
      private def attributes
        {
          # user_hash: '',
          user_id: shop_attributes['myshopify_domain'],
          email: shop_attributes['email'],
          name: shop_attributes['name']
        }
      end

      #
      # These custom attributes are prefixed with 'merchant_' to distinguish
      # from the Shopify intergration's 'shopify_' prefix.
      #
      private def custom_shopify_attributes
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
      private def custom_app_attributes
        app_attributes.each_with_object({}) do |(k, v), h|
          h["#{Lucid::Intercom::APP_PREFIX}_#{k}"] = v
        end
      end

      private def custom_attributes
        custom_shopify_attributes.merge(custom_app_attributes)
      end
    end
  end
end
