# frozen_string_literal: true

require 'lucid_intercom/company_custom_attributes'

require_relative 'attributes_shared_examples'

RSpec.describe LucidIntercom::CompanyCustomAttributes do
  subject(:attributes) { LucidIntercom::CompanyCustomAttributes.new(shopify_data, plan: 'free') }

  include_examples 'attributes'
  include_fixtures 'shopify_data.yml'

  it 'has custom merchant attributes' do
    expect(attributes.to_h).to include(
      :merchant_domain,
      :merchant_myshopify_domain,
      :merchant_shop_owner,
      :merchant_timezone
    )
  end

  it 'has custom app attributes' do
    prefix = LucidIntercom.config.app_prefix

    expect(attributes.to_h).to include("#{prefix}_plan" => 'free')
  end
end
