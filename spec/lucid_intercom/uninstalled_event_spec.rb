# frozen_string_literal: true

require 'lucid_intercom/uninstalled_event'

require_relative 'event_shared_examples'

RSpec.describe LucidIntercom::UninstalledEvent do
  subject(:event) { LucidIntercom::UninstalledEvent.new(shopify_data) }

  include_examples 'event'
  include_fixtures 'shopify_data.yml'

  it { is_expected.to have_attributes(event_name: a_string_ending_with('_uninstalled')) }
  it { is_expected.to have_attributes(app_data: {plan: nil}) }
end
