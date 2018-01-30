# frozen_string_literal: true

require 'lucid_intercom/credentials'
require 'lucid_intercom/send_event'
require 'lucid_intercom/update_user'
require 'lucid_intercom/events/base'

module LucidIntercom
  module Events
    class ChangedPlan < Base
      #
      # @param plan_name [String, nil] e.g. 'free', or nil to unset
      #
      def call(plan_name)
        LucidIntercom::UpdateUser.new(shop_attributes, {plan: plan_name}, credentials).()
        LucidIntercom::SendEvent.new(shop_attributes, credentials).(event_name, event_metadata(plan_name))
      end

      #
      # @return [String]
      #
      private def event_name
        "#{credentials.app_prefix}_changed_plan"
      end

      #
      # @return [Hash]
      #
      private def event_metadata(plan_name)
        {
          company_id: shop_attributes['myshopify_domain'],
          new_plan: plan_name
        }
      end
    end
  end
end
