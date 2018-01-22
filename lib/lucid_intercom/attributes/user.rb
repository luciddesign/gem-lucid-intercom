require 'openssl'
require 'lucid_intercom/attributes/base'

module LucidIntercom
  class Attributes
    class User < Base
      #
      # Standard Intercom user attributes.
      #
      # @return [Hash]
      #
      private def attributes
        {
          # NOTE: currently unused in favour of email # user_id: shop_attributes['myshopify_domain'],
          user_hash: user_hash(shop_attributes['email']),
          email: shop_attributes['email'],
          name: shop_attributes['shop_owner']
        }
      end

      private def user_hash(email)
        OpenSSL::HMAC.hexdigest('sha256', credentials.secret, email)
      end
    end
  end
end

