module BugherdClient
  module Resources
    module V2
      class User < Base

        #
        # See all the people in your account.
        #
        def all
          raw_response = get_request('users')
          parse_response(raw_response, :users)
        end

        #
        # See all your account members
        #
        def members
          raw_response = get_request('users/members')
          parse_response(raw_response, :users)
        end

        #
        # See all the guest in your account
        #
        def guests
          raw_response = get_request('users/guests')
          parse_response(raw_response, :users)
        end

      end
    end
  end
end