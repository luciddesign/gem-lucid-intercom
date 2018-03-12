# frozen_string_literal: true

module LucidIntercom
  class Convert
    #
    # @param attributes [Hash]
    #
    # @return [Hash]
    #
    private def call(attributes)
      attributes.each_with_object({}) do |(k, obj), h|
        h[k] = convert(obj)
      end
    end

    #
    # @param obj [Object]
    #
    # @return [Object] a valid Intercom type
    #
    private def convert(obj)
      case obj
      when Numeric, nil # nil to unset
        obj
      when Time
        obj.to_i
      else
        obj.to_s
      end
    end
  end
end
