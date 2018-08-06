# frozen_string_literal: true

require 'lucid_intercom/container'

module LucidIntercom
  class Event
    #
    # @param post_request [#call]
    # @param update_user [#call]
    #
    def initialize(post_request: Container[:post_request],
                   update_user: Container[:update_user])
      @post_request = post_request
      @update_user = update_user
    end

    #
    # @param shopify_data_or_user [Hash, UserAttributes] shop attributes as returned by the Shopify API
    # @param *args [Array<Object>]
    #
    def notify(shopify_data_or_user, *args)
      user = shopify_data_or_user
      user = UserAttributes.new(user, app_data(*args)) if user.is_a?(Hash)

      @post_request.('events', data(user, *args)).assert!

      @update_user.(user)
    end

    alias_method :call, :notify

    #
    # @param user [UserAttributes]
    # @param *args [Array<Object>]
    #
    # @return [Hash]
    #
    private def data(user, *args)
      {
        **data_user_id(user),
        event_name: name,
        created_at: Time.now.utc.to_i,
        metadata: metadata(user, *args),
      }
    end

    #
    # @param user [UserAttributes]
    #
    # @return [Hash]
    #
    private def data_user_id(user)
      {
        user.id_key => user.id,
      }
    end

    #
    # Set the event name for the subclass.
    #
    # @param name [String, #to_s]
    #
    # @example
    #   event :changed_plan
    #
    def self.event(name)
      define_method(:name) { "#{LucidIntercom.app_prefix}_#{name}" }

      private :name
    end

    #
    # @abstract
    #
    # @return [String]
    #
    private def name
      raise NotImplementedError
    end

    #
    # @abstract
    #
    # @param user [UserAttributes]
    # @param *args [Array<Object>]
    #
    # @return [Hash]
    #
    private def metadata(user, *args)
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
    private def app_data(*)
      {}
    end
  end
end
