# frozen_string_literal: true

require 'lucid_intercom/changed_plan_event'

require_relative 'event_shared_examples'

RSpec.describe LucidIntercom::ChangedPlanEvent do
  subject(:event) { LucidIntercom::ChangedPlanEvent.new(shopify_data, 'plus') }

  include_fixtures 'shopify_data.yml'
  
  it_behaves_like 'event' do
    it { is_expected.to have_attributes(event_name: a_string_ending_with('_changed_plan')) }
    it { is_expected.to have_attributes(event_metadata: a_hash_including(new_plan: 'plus')) }
    it { is_expected.to have_attributes(app_data: {plan: 'plus'}) }
  end
end
