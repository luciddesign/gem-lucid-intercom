# frozen_string_literal: true

require 'lucid_intercom/credentials'
require 'lucid_intercom/send_event'
require 'lucid_intercom/update_user'
require 'lucid_intercom/events/base'

module LucidIntercom
  module Events
    class Uninstalled < Base
      def call
        LucidIntercom::UpdateUser.new(shop_attributes, {plan: nil}, credentials).()
        LucidIntercom::SendEvent.new(shop_attributes, credentials).(event_name, event_metadata)
      end

      #
      # @return [String]
      #
      private def event_name
        "#{credentials.app_prefix}_uninstalled"
      end

      #
      # @return [Hash]
      #
      private def event_metadata
        {
          company_id: shop_attributes['myshopify_domain']
        }
      end
    end
  end
end
