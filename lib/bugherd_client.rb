require 'her'
require 'bugherd_client/monkey_patch'

module BugherdClient
  autoload :VERSION, "bugherd_client/version"
  autoload :Client,  "bugherd_client/client"
  module Resources
    autoload :Base, "bugherd_client/resources/base"
    autoload :Organization,  "bugherd_client/resources/organization"
    autoload :User,  "bugherd_client/resources/user"
  end
end
