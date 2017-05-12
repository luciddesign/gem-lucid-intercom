require_relative './base'

module Lucid
  module Intercom
    class Attributes
      class User < Base
        #
        # Standard Intercom user attributes.
        #
        # @return [Hash]
        #
        private def attributes
          {
            # NOTE: currently unused # user_hash: '',
            # NOTE: currently unused # user_id: shop_attributes['myshopify_domain'],
            email: shop_attributes['email'],
            name: shop_attributes['shop_owner']
          }
        end
      end
    end
  end
end

