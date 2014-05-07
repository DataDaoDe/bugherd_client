module BugherdClient
  module Resources
    class Organization < Base

      #
      # Get more detail of your account.
      # 
      def get
        raw_response = self.connection['organization'].get
        parse_response(raw_response, :organization)
      end
    end
  end
end