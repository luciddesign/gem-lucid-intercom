# frozen_string_literal: true

RSpec.describe LucidIntercom.config do
  it { is_expected.to have_attributes(access_token: 'fake') }
  it { is_expected.to have_attributes(admin_id: 123) }
  it { is_expected.to have_attributes(app_id: 'fake') }
  it { is_expected.to have_attributes(app_prefix: 'fake') }
  it { is_expected.to have_attributes(secret: 'fake') }
end
