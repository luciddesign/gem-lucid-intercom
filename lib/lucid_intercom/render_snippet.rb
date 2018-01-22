require 'erb'
require 'lucid_intercom/attributes'
require 'lucid_intercom/credentials'

module LucidIntercom
  class RenderSnippet
    TEMPLATE = ERB.new(File.read("#{__dir__}/snippet.html.erb")).freeze

    #
    # Leave arguments unset for unauthenticated visitors.
    #
    # @see LucidIntercom::Attributes#initialize
    #
    def initialize(*args, credentials: LucidIntercom.credentials)
      @attributes = args[0].empty? ? nil : Attributes.new(*args, credentials: credentials)
      @credentials = credentials
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
