# frozen_string_literal: true

require 'lucid_intercom/company_custom_attributes'

require_relative 'attributes_shared_examples'

RSpec.describe LucidIntercom::CompanyCustomAttributes do
  subject(:attributes) { LucidIntercom::CompanyCustomAttributes.new(shopify_data, plan: 'free') }

  include_examples 'attributes'
  include_fixtures 'shopify_data.yml'

  describe '#to_h' do
    subject { attributes.to_h }

    it { is_expected.to include(:merchant_domain) }
    it { is_expected.to include(:merchant_myshopify_domain) }
    it { is_expected.to include(:merchant_shop_owner) }
    it { is_expected.to include(:merchant_timezone) }
    it { is_expected.to include("#{LucidIntercom.config.app_prefix}_plan" => 'free') }
  end
end
