# frozen_string_literal: true

require 'erb'

require 'lucid_intercom/config'

module LucidIntercom
  class RenderSnippet
    TEMPLATE = ERB.new(File.read("#{__dir__}/snippet.html.erb")).freeze

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
      company = CompanyAttributes.new(shopify_data).to_h(browser: true)
      company_custom = CompanyCustomAttributes.new(shopify_data, app_data).to_h
      user = UserAttributes.new(shopify_data).to_h(browser: true)

      TEMPLATE.result(binding)
    end

    #
    # Quote and escape a value for JavaScript.
    #
    # @param obj [Object]
    #
    # @return [Object]
    #
    def escape(obj)
      return obj unless obj.is_a?(String)

      s = obj.gsub(/./) do |c|
        return c unless %w(" ' / < > \\).include?(c)

        "\\#{c}"
      end

      "\"#{s}\""
    end
  end
end
