# frozen_string_literal: true

require 'lucid_intercom/installed_event'

require_relative 'event_shared_examples'

module LucidIntercom
  RSpec.describe InstalledEvent do
    subject(:event) { InstalledEvent.new(shopify_data, 'free') }

    include_fixtures 'shopify_data.yml'

    it_behaves_like 'event' do
      it { is_expected.to have_attributes(event_name: a_string_ending_with('_installed')) }
      it { is_expected.to have_attributes(event_metadata: a_hash_including(new_plan: 'free')) }
      it { is_expected.to have_attributes(app_data: {plan: 'free'}) }
    end
  end
end
