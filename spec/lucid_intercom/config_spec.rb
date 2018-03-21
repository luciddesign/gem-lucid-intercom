# frozen_string_literal: true

require 'lucid_intercom/config'

RSpec.describe LucidIntercom::Config do
  let(:config) { LucidIntercom.config }

  it 'has attributes' do
    expect(config.access_token).to eq('fake_access_token')
    expect(config.secret).to eq('fake_secret')
    expect(config.app_id).to eq('fake_app_id')
    expect(config.app_prefix).to eq('fake_app_prefix')
  end

  it 'has attributes forwarded from the root module' do
    expect(LucidIntercom.access_token).to eq('fake_access_token')
    expect(LucidIntercom.secret).to eq('fake_secret')
    expect(LucidIntercom.app_id).to eq('fake_app_id')
    expect(LucidIntercom.app_prefix).to eq('fake_app_prefix')
  end

  it 'raises an error when unset' do
    old_config = config

    LucidIntercom.config = nil
    expect { LucidIntercom.config.app_prefix }.to raise_error(LucidIntercom::NotConfiguredError)
    LucidIntercom.config = old_config
  end
end
