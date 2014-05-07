module BugherdClient
  module Resources
    module V1
      class User < Base

        #
        # See all the people in your account.
        #
        def all
          raw_response = get_request('users')
          parse_response(raw_response, :users)
        end

      end
    end
  end
end