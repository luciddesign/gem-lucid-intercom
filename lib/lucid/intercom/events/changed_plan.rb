require_relative '../../intercom'
require_relative '../send_event'
require_relative '../update_user'

module Lucid
  module Intercom
    module Events
      class ChangedPlan < Base
        #
        # @param plan_name [String, nil] e.g. 'free', or nil to unset
        #
        def call(plan_name)
          Lucid::Intercom::UpdateUser.new(shop_attributes, {plan: plan_name}).()
          Lucid::Intercom::SendEvent.new(shop_attributes).(event_name, event_metadata(plan_name))
        end

        #
        # @return [String]
        #
        private def event_name
          "#{Lucid::Intercom::APP_PREFIX}_changed_plan"
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
end
