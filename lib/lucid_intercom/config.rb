# frozen_string_literal: true

require 'lucid_intercom'
require 'lucid_utils'

module LucidIntercom
  NotConfiguredError = Class.new(Error)

  class << self
    #
    # @param options [Hash]
    #
    # @return [Config]
    #
    def configure(options = {})
      @config = Config.new(
        **@config.to_h.compact,
        **options,
      )
    end

    #
    # @param path [String]
    #
    # @return [Config]
    #
    def configure_from_file(path = 'config/intercom.rb')
      options = LucidUtils::ConfigFromFile.new.(path, env_prefix: 'intercom')

      configure(options)
    end

    #
    # @return [Config]
    #
    def config
      @config ||= configure
    end
  end

  class Config < Dry::Struct
    attribute :access_token, Types::String
    attribute :admin_id, Types::Integer
    attribute :app_id, Types::String
    attribute :app_prefix, Types::String # the snakecased app name, e.g. 'smart_order_tags'
    attribute :secret, Types::String
  end
end
