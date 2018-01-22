module LucidIntercom
  #
  # Subclass this class for all gem exceptions, so that callers may rescue
  # any subclass with:
  #
  #     rescue LucidIntercom::Error => e
  #
  Error = Class.new(StandardError)
end
