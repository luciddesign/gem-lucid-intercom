require 'erb'

require_relative '../intercom'
require_relative './attributes'

module Lucid
  class Intercom
    class RenderSnippet
      TEMPLATE = ERB.new(File.read("#{__dir__}/snippet.html.erb")).freeze

      #
      # Leave arguments unset for unauthenticated visitors.
      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param app_attributes [Hash] app-specific attributes (unprefixed)
      #
      # @return [String] the rendered tracking script HTML
      #
      def call(shop_attributes = {}, app_attributes = {})
        attributes = shop_attributes.empty? ? {} : Attributes.new(
          shop_attributes,
          app_attributes
        ).for_browser

        TEMPLATE.result(binding)
      end

      private def render_attribute(v)
        v.is_a?(String) ? "\"#{ERB::Util.h(v)}\"" : v
      end
    end
  end
end
