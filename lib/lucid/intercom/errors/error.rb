module Lucid
  module Intercom
    #
    # Subclass this class for all gem exceptions, so that callers may rescue
    # any subclass with:
    #
    #     rescue Lucid::Intercom::Error => e
    #
    class Error < StandardError
    end
  end
end
