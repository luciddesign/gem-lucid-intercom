# frozen_string_literal: true

require 'lucid_intercom/config'

module LucidIntercom
  class RenderSnippet
    TEMPLATE = File.read("#{__dir__}/snippet.html").freeze

    #
    # @param shopify_data [Hash] shop attributes as returned by the Shopify API
    # @param app_data [Hash] app attributes (unprefixed)
    #
    # @example Unauthenticated visitor
    #   render_snippet.()
    #
    # @example
    #   render_snippet.(shopify_data, app_data)
    #
    # @return [String]
    #
    def call(shopify_data = {}, app_data = {})
      settings = UserAttributes.new(shopify_data).to_h(browser: true)
      settings[:app_id] = LucidIntercom.app_id
      settings[:company] = CompanyAttributes.new(shopify_data).to_h(browser: true).merge(CompanyCustomAttributes.new(shopify_data, app_data).to_h)

      TEMPLATE % {
        settings: settings.to_json,
        app_id: settings[:app_id],
      }
    end
  end
end
