# frozen_string_literal: true

require 'lucid_intercom/event'

RSpec.shared_examples 'event' do
  it 'has attributes' do
    expect(event.company).to be_a(LucidIntercom::CompanyAttributes)
    expect(event.company_custom).to be_a(LucidIntercom::CompanyCustomAttributes)
    expect(event.user).to be_a(LucidIntercom::UserAttributes)
  end

  it 'has an event_name prefixed with the app name' do
    expect(event.event_name).to start_with(LucidIntercom.app_prefix + '_')
  end

  it 'has event_metadata identified with the myshopify_domain' do
    expect(event.event_metadata).to be_a(Hash)
    expect(event.event_metadata).to include(company_id: event.shopify_data['myshopify_domain'])
  end

  it 'has app_data' do
    expect(event.event_metadata).to be_a(Hash)
  end

  it 'has a user_id identified with the email address' do
    expect(event.user_id).to eq(email: event.shopify_data['email'])
  end
end
