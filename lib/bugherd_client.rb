require 'rest_client'
require 'active_support'
require 'active_support/core_ext'

module BugherdClient
  autoload :VERSION, "bugherd_client/version"
  autoload :Client,  "bugherd_client/client"
  autoload :Errors,  "bugherd_client/errors"
  module Resources
    autoload :Base,           "bugherd_client/resources/base"
    autoload :Organization,   "bugherd_client/resources/organization"
    autoload :User,           "bugherd_client/resources/user"
    autoload :Project,        "bugherd_client/resources/project"
    autoload :Task,           "bugherd_client/resources/task"
    autoload :Comment,        "bugherd_client/resources/comment"
  end
end
