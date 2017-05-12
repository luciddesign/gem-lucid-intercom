require_relative './base'

module Lucid
  module Intercom
    class Attributes
      class Company < Base
        #
        # Standard Intercom company attributes.
        #
        # @return [Hash]
        #
        private def attributes
          {
            company_id: shop_attributes['myshopify_domain'],
            name: shop_attributes['name']
          }
        end
      end
    end
  end
end

