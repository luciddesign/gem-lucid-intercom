# frozen_string_literal: true

RSpec.describe LucidIntercom.config do
  it { is_expected.to have_attributes(access_token: 'fake') }
  it { is_expected.to have_attributes(secret: 'fake') }
  it { is_expected.to have_attributes(app_id: 'fake') }
  it { is_expected.to have_attributes(app_prefix: 'fake') }

  it 'raises an error when unset' do
    LucidIntercom.config = nil

    expect { LucidIntercom.config.api_key }.to raise_error(LucidIntercom::NotConfiguredError)

    LucidIntercom.config = subject
  end
end

RSpec.describe LucidIntercom do
  it { is_expected.to have_attributes(access_token: 'fake') }
  it { is_expected.to have_attributes(secret: 'fake') }
  it { is_expected.to have_attributes(app_id: 'fake') }
  it { is_expected.to have_attributes(app_prefix: 'fake') }
end
