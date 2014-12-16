module BugherdClient
  module Errors

    class InvalidOption < StandardError
      def initialize(msg='invalid option')
        super(msg)
      end
    end

    class NotAvailable < StandardError
      def initialize(api_version, msg='')
        super("#{msg} not available in API v#{api_version}")
      end
    end

    class InvalidQueryKey < StandardError
      def initialize(given = '', valid_keys = [])
        super("invalid query key: got #{given} but expected one of #{valid_keys.join(',')}")
      end
    end

    class HttpRequestError < StandardError
      attr_accessor :http_code
      def initialize(message = '', code = 500)
        super(message)
        @http_code = code
      end
    end

    class UnsupportedMethod < StandardError
      def initialize(api_version='')
        super("Method supported in API version #{api_version}")
      end
    end

    class UnsupportedAttribute < StandardError
      def initialize(api_version='', attrs=[])
        super("Attributes (#{attrs.join(',')}) supported in #{api_version}")
      end
    end
  end
end
