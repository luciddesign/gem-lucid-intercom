# frozen_string_literal: true

require 'lucid_intercom/attributes'

module LucidIntercom
  class CompanyAttributes < Attributes
    #
    # @param browser [Boolean] format for browser snippet
    # @param convert [#call]
    #
    # @return [Hash]
    #
    def to_h(browser: false, convert: Convert.new)
      convert.({}.tap do |h|
        h[browser ? :id : :company_id] = shopify_data['myshopify_domain']
        h[:name] = shopify_data['name']
        h[:plan] = shopify_data['plan_name']
      end)
    end
  end
end
