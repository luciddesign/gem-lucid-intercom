# frozen_string_literal: true

require 'lucid_intercom/installed_event'
require 'lucid_intercom/send_event'

require_relative 'post_request_double'

module LucidIntercom
  RSpec.describe SendEvent do
    let(:event) { InstalledEvent.new(shopify_data, 'free') }
    let(:post_request) { PostRequestDouble.new }
    let(:update_user) { instance_double('UpdateUser') }

    subject(:send_event) do
      SendEvent.new(
        post_request: post_request,
        update_user: update_user
      )
    end

    before do
      allow(update_user).to receive(:call)
    end

    include_fixtures 'shopify_data.yml'

    it 'posts the event data' do
      data = hash_including(
        event.user.id_key,
        created_at: within(1).of(Time.now.utc.to_i),
        event_name: event.event_name,
        metadata: event.event_metadata
      )

      expect(post_request).to receive(:call).with('events', data).and_call_original

      send_event.(event)
    end

    it 'updates the user' do
      expect(update_user).to receive(:call).with(event)

      send_event.(event)
    end
  end
end
