# frozen_string_literal: true

require 'erb'
require 'lucid_intercom/attributes'
require 'lucid_intercom/credentials'

module LucidIntercom
  class RenderSnippet
    TEMPLATE = ERB.new(File.read("#{__dir__}/snippet.html.erb")).freeze

    #
    # Leave arguments unset for unauthenticated visitors.
    #
    # @param credentials [LucidIntercom::Credentials]
    #
    # @see LucidIntercom::Attributes#initialize
    #
    def initialize(shop_attributes = {}, app_attributes = {}, credentials = LucidIntercom.credentials)
      @credentials = credentials
      @attributes = shop_attributes.empty? ? nil : Attributes.new(
        shop_attributes,
        app_attributes,
        credentials
      )
    end

    # @return [LucidIntercom::Attributes]
    attr_reader :attributes
    # @return [LucidIntercom::Credentials]
    attr_reader :credentials

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
      v.is_a?(String) ? ?" + v.gsub(/./) { |c| escape_char(c) } + ?" : v
    end

    private def escape_char(c)
      %w(" ' / < > \\).include?(c) ? '\%s' % c : c
    end
  end
end
