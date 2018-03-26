# frozen_string_literal: true

require 'lucid_intercom/installed_event'
require 'lucid_intercom/update_user'

require_relative 'post_request_double'

RSpec.describe LucidIntercom::UpdateUser do
  let(:event) { LucidIntercom::InstalledEvent.new(shopify_data, 'free') }
  let(:post_request) { PostRequestDouble.new }

  subject(:update_user) do
    LucidIntercom::UpdateUser.new(
      post_request: post_request
    )
  end

  include_fixtures 'shopify_data.yml'

  it 'posts the updated user data' do
    data = hash_including(
      companies: [
        hash_including(
          custom_attributes: hash_including(
            'fake_plan' => 'free'
          )
        ),
      ]
    )

    expect(post_request).to receive(:call).with('users', data).and_call_original

    update_user.(event)
  end
end
