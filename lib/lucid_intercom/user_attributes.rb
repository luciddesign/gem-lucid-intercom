# frozen_string_literal: true

require 'lucid_intercom/attributes'
require 'lucid_intercom/config'

module LucidIntercom
  class UserAttributes < Attributes
    #
    # @param browser [Boolean] format for browser snippet
    # @param convert [#call]
    #
    # @return [Hash]
    #
    def to_h(browser: false, convert: Convert.new)
      convert.({}.tap do |h|
        h[:user_hash] = user_hash(id) if browser # or myshopify_domain
        h[:email] = shopify_data['email']
        h[:name] = shopify_data['shop_owner']
      end)
    end

    #
    # Either {:user_id} or {:email}. Currently, we are using the email address.
    #
    # @return [Symbol]
    #
    def id_key
      :email
    end

    #
    # @return [String]
    #
    def id
      shopify_data[id_key.to_s]
    end

    #
    # @param email [String]
    #
    # @return [String]
    #
    private def user_hash(email)
      OpenSSL::HMAC.hexdigest('sha256', LucidIntercom.secret, email)
    end
  end
end
