require_relative '../../intercom'
require_relative './base'

module Lucid
  module Intercom
    class Attributes
      class Custom < Base
        #
        # Custom company attributes.
        #
        # @return [Hash]
        #
        private def attributes
          super
            .merge(attributes_shopify)
            .merge(attributes_app)
        end

        #
        # These custom attributes are prefixed with 'merchant_' to distinguish
        # from the Shopify intergration's 'shopify_' prefix.
        #
        # @return [Hash]
        #
        private def attributes_shopify
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
        # @return [Hash]
        #
        private def attributes_app
          app_prefix = Lucid::Intercom::APP_PREFIX

          app_attributes.each_with_object({}) do |(k, v), a|
            a["#{app_prefix}_#{k}"] = v
          end
        end
      end
    end
  end
end

