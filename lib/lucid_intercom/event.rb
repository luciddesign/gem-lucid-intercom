# frozen_string_literal: true

require 'lucid_intercom'

module LucidIntercom
  class Event
    extend Dry::Initializer

    # @return [Hash] shop attributes as returned by the Shopify API
    param :shopify_data
    # @return [CompanyAttributes]
    option :company, default: proc { CompanyAttributes.new(shopify_data) }
    # @return [CompanyCustomAttributes]
    option :company_custom, default: proc { CompanyCustomAttributes.new(shopify_data, app_data) }
    # @return [UserAttributes]
    option :user, default: proc { UserAttributes.new(shopify_data) }

    #
    # Set the event name for the subclass.
    #
    # @param event_name [String, #to_s]
    #
    # @example
    #   event :changed_plan
    #
    def self.event(event_name)
      define_method(:event_name) do
        "#{LucidIntercom.app_prefix}_#{event_name}"
      end
    end

    #
    # @abstract
    #
    # @return [String]
    #
    def event_name
      raise NotImplementedError
    end

    #
    # @abstract
    #
    # @return [Hash]
    #
    def event_metadata
      raise NotImplementedError
    end

    #
    # Additional custom attributes related to the event (unprefixed).
    #
    # @example
    #   {plan: 'free'}
    #
    # @example
    #   {plan: nil}
    #
    # @return [Hash]
    #
    def app_data
      {}
    end

    #
    # @return [Hash]
    #
    def user_id
      {
        user.id_key => user.id,
      }
    end
  end
end
