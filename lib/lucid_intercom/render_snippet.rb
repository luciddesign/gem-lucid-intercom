# frozen_string_literal: true

require 'lucid_intercom'

module LucidIntercom
  class RenderSnippet
    TEMPLATE = File.read("#{__dir__}/snippet.html").freeze

    #
    # @param shopify_data_or_user [Hash, UserAttributes] shop attributes as returned by the Shopify API
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
    def call(shopify_data_or_user = {}, app_data = {})
      user = shopify_data_or_user
      user = UserAttributes.new(user, app_data) if user.is_a?(Hash)

      settings = shopify_data_or_user.is_a?(Hash) && shopify_data_or_user.empty? ? unauthenticated_settings : authenticated_settings(user)

      TEMPLATE % {settings: settings.to_json, app_id: settings[:app_id]}
    end

    #
    # @return [Hash]
    #
    private def unauthenticated_settings
      {
        app_id: LucidIntercom.config.app_id,
      }
    end

    #
    # @param user [UserAttributes]
    #
    # @return [Hash]
    #
    private def authenticated_settings(user)
      {
        **unauthenticated_settings,
        **user.to_h(browser: true),
        company: user.company.to_h(browser: true).merge(user.company.custom.to_h),
      }
    end
  end
end
