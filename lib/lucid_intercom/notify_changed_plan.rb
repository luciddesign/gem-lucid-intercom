# frozen_string_literal: true

require 'lucid_intercom/event'

module LucidIntercom
  class NotifyChangedPlan < Event
    event :changed_plan

    #
    # @see Event#metadata
    #
    private def metadata(user, new_plan)
      {
        company_id: user.company.to_h[:company_id],
        new_plan: new_plan,
      }
    end

    #
    # @param new_plan [String, nil] e.g. 'free', or nil to unset
    #
    # @return [Hash]
    #
    private def app_data(new_plan)
      {
        plan: new_plan,
      }
    end
  end
end
