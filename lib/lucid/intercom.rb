module Lucid
  class Intercom
    APP_ID = ENV['INTERCOM_APP_ID'].dup.freeze || ''
    APP_PREFIX = ENV['INTERCOM_APP_PREFIX'].dup.freeze || ''
  end
end
