module BugherdClient
  module Resources
    module V2

      class Organization < Base

        #
        # Get more detail of your account.
        #
        def get
          raw_response = self.connection['organization'].get
          parse_response(raw_response, :organization)
        end
      end

    end # V2
  end # Resources
end # BugherdClient
