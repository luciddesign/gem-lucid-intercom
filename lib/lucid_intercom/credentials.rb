module LucidIntercom
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

class << LucidIntercom
  #
  # Assign default API credentials.
  #
  # @param credentials [LucidIntercom::Credentials]
  #
  attr_writer :credentials

  #
  # @return [LucidIntercom::Credentials]
  #
  # @raise [LucidIntercom::MissingCredentialsError] if credentials are unset
  #
  def credentials
    raise MissingCredentialsError unless @credentials

    @credentials
  end
end
