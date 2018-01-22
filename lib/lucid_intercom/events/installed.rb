require_relative '../credentials'
require_relative '../send_event'
require_relative '../update_user'
require_relative './base'

module LucidIntercom
  module Events
    class Installed < Base
      #
      # @param plan_name [String] e.g. 'free'
      #
      def call(plan_name)
        LucidIntercom::UpdateUser.new(shop_attributes, {plan: plan_name}, credentials: credentials).()
        LucidIntercom::SendEvent.new(shop_attributes, credentials: credentials).(event_name, event_metadata(plan_name))
      end

      #
      # @return [String]
      #
      private def event_name
        "#{credentials.app_prefix}_installed"
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
