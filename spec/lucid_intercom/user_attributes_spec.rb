# frozen_string_literal: true

require 'lucid_intercom/user_attributes'

require_relative 'attributes_shared_examples'

module LucidIntercom
  RSpec.describe UserAttributes do
    subject(:attributes) { UserAttributes.new(shopify_data) }

    include_fixtures 'shopify_data.yml'

    it_behaves_like 'attributes'

    context 'for event, #to_h' do
      subject { attributes.to_h }

      it { is_expected.to include(:email) }
      it { is_expected.to include(:name) }
      it { is_expected.to not_include(:user_hash) }
    end

    context 'for browser, #to_h' do
      subject { attributes.to_h(browser: true) }

      it { is_expected.to include(:email) }
      it { is_expected.to include(:name) }
      it { is_expected.to include(:user_hash) }
    end

    it 'has #id_key' do
      expect(attributes.id_key).to be(:email)
    end

    it 'has #id' do
      expect(attributes.id).to eq(shopify_data['email'])
    end
  end
end
