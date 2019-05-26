# frozen_string_literal: true

module LucidIntercom
  RSpec.describe UpdateUser do
    let(:post_request) { instance_double('PostRequest') }
    let(:user) { UserAttributes.new(shopify_data, {plan: 'free'}) }

    subject(:update_user) do
      UpdateUser.new(
        post_request: post_request
      )
    end

    include_fixtures 'shopify_data.yml'

    it 'posts the updated user data' do
      expect(post_request).to receive(:call) do |path, data|
        expect(path).to eq('users')
        expect(data).to include(
          companies: [
            hash_including(
              custom_attributes: hash_including(
                'fake_plan' => 'free'
              )
            ),
          ]
        )

        Response.new(200, {}, '{}') # for #assert!
      end

      update_user.(user)
    end
  end
end
