# frozen_string_literal: true

require 'lucid_intercom/attributes/base'

module LucidIntercom
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
          name: shop_attributes['name'],
          plan: shop_attributes['plan_name'],
        }
      end
    end
  end
end
