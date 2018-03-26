# frozen_string_literal: true

require 'lucid_intercom/user_attributes'

require_relative 'attributes_shared_examples'

RSpec.describe LucidIntercom::UserAttributes do
  subject(:attributes) { LucidIntercom::UserAttributes.new(shopify_data) }

  include_examples 'attributes'
  include_fixtures 'shopify_data.yml'

  it 'has user attributes' do
    expect(attributes.to_h).to include(:email, :name)
  end

  context 'for event' do
    subject { attributes.to_h }

    it { is_expected.to not_include(:user_hash) }
  end

  context 'for browser' do
    subject { attributes.to_h(browser: true) }

    it { is_expected.to include(:user_hash) }
  end

  it 'has id_key' do
    expect(attributes.id_key).to be(:email)
  end

  it 'has id' do
    expect(attributes.id).to eq(shopify_data['email'])
  end
end
