# frozen_string_literal: true

require 'lucid_intercom/container'

module LucidIntercom
  class CompanyCustomAttributes < Attributes
    # @return [Hash] app attributes (unprefixed)
    param :app_data, reader: :private

    #
    # @param convert [#call]
    #
    # @return [Hash]
    #
    def to_h(convert: Container[:convert])
      convert.(shopify.merge(app))
    end

    #
    # These attributes are prefixed with 'merchant_' to distinguish them from
    # the Shopify intergration's 'shopify_' prefix.
    #
    # @return [Hash]
    #
    private def shopify
      {
        merchant_domain: shopify_data['domain'],
        merchant_myshopify_domain: shopify_data['myshopify_domain'],
        merchant_shop_owner: shopify_data['shop_owner'],
        merchant_timezone: shopify_data['timezone'],
      }
    end

    #
    # Any app-specific attributes.
    #
    # @return [Hash]
    #
    private def app
      prefix = LucidIntercom.app_prefix

      app_data.each_with_object({}) do |(k, v), h|
        h["#{prefix}_#{k}"] = v
      end
    end
  end
end
