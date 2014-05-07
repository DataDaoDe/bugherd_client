module BugherdClient
  module Resources
    class Organization < Base

      #
      # Get more detail of your account.
      # API: 2
      def get
        raise BugherdClient::Errors::UnsupportedMethod, :v2 unless self.options[:api_version].eql?(2)
        raw_response = self.connection['organization'].get
        parse_response(raw_response, :organization)
      end
    end
  end
end