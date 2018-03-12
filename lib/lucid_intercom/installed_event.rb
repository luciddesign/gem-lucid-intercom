# frozen_string_literal: true

require 'lucid_intercom/event'

module LucidIntercom
  class InstalledEvent < Event
    # @return [String] e.g. 'free'
    param :new_plan

    event :installed

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
