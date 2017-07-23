require 'erb'

require_relative '../intercom'
require_relative './attributes'

module Lucid
  module Intercom
    class RenderSnippet
      TEMPLATE = ERB.new(File.read("#{__dir__}/snippet.html.erb")).freeze

      #
      # Leave arguments unset for unauthenticated visitors.
      #
      # @see Lucid::Intercom::Attributes#initialize
      #
      def initialize(*args, credentials: nil)
        @credentials = credentials || Lucid::Intercom.credentials

        @attributes = args[0].empty? ? nil : Attributes.new(*args, credentials: @credentials)
      end

      attr_reader :attributes
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
end
