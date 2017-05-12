module Lucid
  class Intercom
    class Attributes
      class Base
        attr_reader :shop_attributes, :app_attributes

        #
        # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
        # @param app_attributes [Hash] app-specific attributes (unprefixed)
        #
        def initialize(shop_attributes, app_attributes)
          @shop_attributes = shop_attributes
          @app_attributes = app_attributes
        end

        #
        # @return [Hash]
        #
        def call
          normalize_values(attributes)
        end

        #
        # @return Hash
        #
        private def attributes
          {}
        end

        #
        # Convert attribute values to valid Intercom types.
        #
        # @param attributes [Hash]
        #
        # @return [Hash]
        #
        private def normalize_values(attributes)
          attributes.each_with_object({}) do |(k, v), a|
            v2 =
              case v
              when Time then v.to_i
              when Integer, Float then v
              else v.to_s
              end

            a[k] = v2
          end
        end
      end
    end
  end
end
