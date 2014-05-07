module BugherdClient
  module Errors

    class InvalidOption < StandardError
      def initialize(msg="invalid option")
        super(msg)
      end
    end

    class UnsupportedMethod < StandardError
      def initialize(api_version="")
        super("Method supported in API version #{api_version}")
      end
    end

    class UnsupportedAttribute < StandardError
      def initialize(api_version="", attrs=[])
        super("Attributes (#{attrs.join(',')}) supported in #{api_version}")
      end
    end
  end
end