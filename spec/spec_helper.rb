# frozen_string_literal: true

$LOAD_PATH.unshift(__dir__ + '/../lib')

require_relative 'support/fixture_helpers'
require_relative 'support/matchers'

RSpec.configure do |config|
  config.expose_dsl_globally = false
  config.include(FixtureHelpers)
end

require 'lucid_intercom'

LucidIntercom.configure(
  access_token: 'fake',
  admin_id: 123,
  app_id: 'fake',
  app_prefix: 'fake',
  secret: 'fake',
)
