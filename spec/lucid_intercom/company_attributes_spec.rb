# frozen_string_literal: true

require 'lucid_intercom/company_attributes'

require_relative 'attributes_shared_examples'

RSpec.describe LucidIntercom::CompanyAttributes do
  subject(:attributes) { LucidIntercom::CompanyAttributes.new(shopify_data) }

  include_examples 'attributes'
  include_fixtures 'shopify_data.yml'

  it 'has company attributes' do
    expect(attributes.to_h).to include(:name, :plan)
  end

  context 'for event' do
    subject { attributes.to_h }

    it { is_expected.to include(:company_id).and not_include(:id) }
  end

  context 'for browser' do
    subject { attributes.to_h(browser: true) }

    it { is_expected.to include(:id).and not_include(:company_id) }
  end
end
