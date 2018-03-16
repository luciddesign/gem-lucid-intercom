# frozen_string_literal: true

require 'lucid_intercom/installed_event'

require_relative 'event_shared_examples'

RSpec.describe LucidIntercom::InstalledEvent do
  let(:event) { LucidIntercom::InstalledEvent.new(fixture('shopify_data.yml'), 'free') }

  include_examples 'event'

  it 'has the correct name' do
    expect(event.event_name).to end_with('_installed')
  end

  it 'has the correct metadata' do
    expect(event.event_metadata.length).to be(2)
    expect(event.event_metadata).to include(new_plan: 'free')
  end

  it 'has the correct app_data' do
    expect(event.app_data.length).to be(1)
    expect(event.app_data).to include(plan: 'free')
  end
end
