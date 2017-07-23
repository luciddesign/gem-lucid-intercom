require 'dry-struct'

require_relative './types'

module Lucid
  module Intercom
    class Credentials < Dry::Struct
      attribute :access_token, Types::Strict::String
      attribute :secret, Types::Strict::String
      attribute :app_id, Types::Strict::String
      attribute :app_prefix, Types::Strict::String
    end
  end
end
