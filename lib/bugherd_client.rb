require 'rest_client'

module BugherdClient
  autoload :VERSION, "bugherd_client/version"
  autoload :Client,  "bugherd_client/client"
  autoload :Errors,  "bugherd_client/errors"
  module Resources
    autoload :Base, "bugherd_client/resources/base"
    autoload :Organization,  "bugherd_client/resources/organization"
    autoload :User,  "bugherd_client/resources/user"
  end
end
