# frozen_string_literal: true

require 'lucid_intercom/changed_plan_event'

require_relative 'event_shared_examples'

RSpec.describe LucidIntercom::ChangedPlanEvent do
  let(:event) { LucidIntercom::ChangedPlanEvent.new(fixture('shopify_data.yml'), 'plus') }

  include_examples 'event'

  it 'has the correct name' do
    expect(event.event_name).to end_with('_changed_plan')
  end

  it 'has the correct metadata' do
    expect(event.event_metadata.length).to be(2)
    expect(event.event_metadata).to include(new_plan: 'plus')
  end

  it 'has the correct app_data' do
    expect(event.app_data.length).to be(1)
    expect(event.app_data).to include(plan: 'plus')
  end
end
