# frozen_string_literal: true

require 'lucid_intercom'

module LucidIntercom
  class UninstalledEvent < Event
    event :uninstalled

    #
    # @return [Hash]
    #
    def event_metadata
      {
        company_id: company.to_h[:company_id],
      }
    end

    #
    # @return [Hash]
    #
    def app_data
      {
        plan: nil,
      }
    end
  end
end
