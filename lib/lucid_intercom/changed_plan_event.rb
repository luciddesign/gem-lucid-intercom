# frozen_string_literal: true

require 'lucid_intercom/event'

module LucidIntercom
  class ChangedPlanEvent < Event
    # @return [String, nil] e.g. 'free', or nil to unset
    param :new_plan

    event :changed_plan

    #
    # @return [Hash]
    #
    def event_metadata
      {
        company_id: company.to_h[:company_id],
        new_plan: new_plan,
      }
    end

    #
    # @return [Hash]
    #
    def app_data
      {
        plan: new_plan,
      }
    end
  end
end
