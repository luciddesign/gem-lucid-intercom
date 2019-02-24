# frozen_string_literal: true

require 'forwardable'

require 'lucid_intercom'

module LucidIntercom
  NotConfiguredError = Class.new(Error)

  class << self
    extend Forwardable

    def_delegators(
      :config,
      :access_token,
      :secret,
      :app_id,
      :app_prefix
    )

    # @param config [Config]
    attr_writer :config

    #
    # @return [Config]
    #
    # @raise [NotConfiguredError] if config is unset
    #
    def config
      raise NotConfiguredError unless @config

      @config
    end
  end

  class Config
    extend Dry::Initializer

    # @return [String]
    param :access_token
    # @return [String]
    param :secret
    # @return [String]
    param :app_id
    # @return [String] the snakecased app name, e.g. 'smart_order_tags'
    param :app_prefix
  end
end
