# frozen_string_literal: true

require 'lucid_intercom/installed_event'

require_relative 'event_shared_examples'

RSpec.describe LucidIntercom::InstalledEvent do
  subject(:event) { LucidIntercom::InstalledEvent.new(shopify_data, 'free') }

  include_examples 'event'
  include_fixtures 'shopify_data.yml'

  it { is_expected.to have_attributes(event_name: a_string_ending_with('_installed')) }
  it { is_expected.to have_attributes(event_metadata: a_hash_including(new_plan: 'free')) }
  it { is_expected.to have_attributes(app_data: {plan: 'free'}) }
end
