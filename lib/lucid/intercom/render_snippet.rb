require 'erb'

require_relative '../intercom'
require_relative './attributes'

module Lucid
  class Intercom
    class RenderSnippet
      TEMPLATE = ERB.new(File.read("#{__dir__}/snippet.html.erb")).freeze

      attr_reader :attributes

      #
      # Leave arguments unset for unauthenticated visitors.
      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param app_attributes [Hash] app-specific attributes (unprefixed)
      #
      def initialize(shop_attributes = {}, app_attributes = {})
        @attributes = shop_attributes.empty? ? nil : Attributes.new(
          shop_attributes,
          app_attributes
        )
      end

      #
      # @return [String] the rendered HTML
      #
      def call
        TEMPLATE.result(binding)
      end

      #
      # Quote and escape a value for the window.intercomSettings object.
      #
      private def h(v)
        v.is_a?(String) ? "\"#{ERB::Util.h(v)}\"" : v
      end
    end
  end
end
