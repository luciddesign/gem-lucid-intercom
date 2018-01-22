module Lucid
  module Intercom
    # @!attribute [rw] access_token
    #   @return [String]
    # @!attribute [rw] secret
    #   @return [String]
    # @!attribute [rw] app_id
    #   @return [String]
    # @!attribute [rw] app_prefix
    #   @return [String] the snakecased app name, e.g. 'smart_order_tags'
    Credentials = Struct.new(:access_token, :secret, :app_id, :app_prefix)
  end
end
