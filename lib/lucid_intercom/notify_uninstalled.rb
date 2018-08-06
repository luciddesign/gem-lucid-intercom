# frozen_string_literal: true

require 'lucid_intercom/event'

module LucidIntercom
  class NotifyUninstalled < Event
    event :uninstalled

    #
    # @see Event#metadata
    #
    private def metadata(user, *args)
      {
        company_id: user.company.to_h[:company_id],
      }
    end

    #
    # @return [Hash]
    #
    private def app_data(*)
      {
        plan: nil,
      }
    end
  end
end
