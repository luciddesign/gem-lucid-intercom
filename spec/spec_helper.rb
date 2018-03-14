# frozen_string_literal: true

$LOAD_PATH << __dir__ + '/../lib'

require_relative 'support/fixture_helpers'

require 'lucid_intercom/config'

LucidIntercom.config = LucidIntercom::Config.new(
  'fake_access_token',
  'fake_secret',
  'fake_app_id',
  'fake_app_prefix'
)
