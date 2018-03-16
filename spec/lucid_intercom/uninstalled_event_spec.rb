# frozen_string_literal: true

require 'lucid_intercom/uninstalled_event'

require_relative 'event_shared_examples'

RSpec.describe LucidIntercom::UninstalledEvent do
  let(:event) { LucidIntercom::UninstalledEvent.new(fixture('shopify_data.yml')) }

  include_examples 'event'

  it 'has the correct name' do
    expect(event.event_name).to end_with('_uninstalled')
  end

  it 'has the correct metadata' do
    expect(event.event_metadata.length).to be(1)
  end

  it 'has the correct app_data' do
    expect(event.app_data.length).to be(1)
    expect(event.app_data).to include(plan: nil)
  end
end
