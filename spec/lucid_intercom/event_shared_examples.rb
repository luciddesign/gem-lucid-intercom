# frozen_string_literal: true

require 'lucid_intercom/event'

RSpec.shared_examples 'event' do
  it { is_expected.to have_attributes(company: instance_of(LucidIntercom::CompanyAttributes)) }
  it { is_expected.to have_attributes(company_custom: instance_of(LucidIntercom::CompanyCustomAttributes)) }
  it { is_expected.to have_attributes(user: instance_of(LucidIntercom::UserAttributes)) }
  it { is_expected.to have_attributes(user_id: {email: shopify_data['email']}) }
  it { is_expected.to have_attributes(event_name: instance_of(String)) }
  it { is_expected.to have_attributes(event_metadata: instance_of(Hash)) }
  it { is_expected.to have_attributes(app_data: instance_of(Hash)) }

  it '#event_name is prefixed with the app name' do
    prefix = LucidIntercom.config.app_prefix

    expect(event.event_name).to start_with("#{prefix}_")
  end

  it '#event_metadata is identified by the myshopify_domain' do
    expect(event.event_metadata).to include(company_id: shopify_data['myshopify_domain'])
  end
end
