module Lucid
  module Intercom
    APP_ACCESS_TOKEN = ENV['INTERCOM_APP_ACCESS_TOKEN'].dup.freeze || STDERR.puts('INTERCOM_APP_ACCESS_TOKEN is unset')
    APP_ID = ENV['INTERCOM_APP_ID'].dup.freeze || STDERR.puts('INTERCOM_APP_ID is unset')
    APP_PREFIX = ENV['INTERCOM_APP_PREFIX'].dup.freeze || STDERR.puts('INTERCOM_APP_PREFIX is unset')
    APP_SECRET = ENV['INTERCOM_APP_SECRET'].dup.freeze || STDERR.puts('INTERCOM_APP_SECRET is unset')
  end
end
