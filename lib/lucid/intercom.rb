module Lucid
  module Intercom
    APP_ACCESS_TOKEN = (ENV['INTERCOM_APP_ACCESS_TOKEN'].dup || '').freeze
    APP_ID = (ENV['INTERCOM_APP_ID'].dup || '').freeze
    APP_PREFIX = (ENV['INTERCOM_APP_PREFIX'].dup || 'app').freeze
  end
end
