# frozen_string_literal: true

require 'lucid_intercom/event'

class EventDouble < LucidIntercom::Event
  param :foo

  event :test

  def event_metadata
    {
      company_id: company.to_h[:company_id],
      foo: foo,
    }
  end

  def app_data
    {
      foo: foo,
    }
  end
end
