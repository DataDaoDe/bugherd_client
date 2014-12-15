require 'rest_client'
require 'hashie'
require 'active_support'
require 'active_support/core_ext'

module BugherdClient
  autoload :VERSION, 'bugherd_client/version'
  autoload :Client,  'bugherd_client/client'
  autoload :Errors,  'bugherd_client/errors'

  module Resources
    module V1
      autoload :Base,           'bugherd_client/resources/v1/base'
      autoload :Organization,   'bugherd_client/resources/v1/organization'
      autoload :User,           'bugherd_client/resources/v1/user'
      autoload :Project,        'bugherd_client/resources/v1/project'
      autoload :Task,           'bugherd_client/resources/v1/task'
      autoload :Comment,        'bugherd_client/resources/v1/comment'
    end

    module V2
      autoload :Base,           'bugherd_client/resources/v2/base'
      autoload :Organization,   'bugherd_client/resources/v2/organization'
      autoload :User,           'bugherd_client/resources/v2/user'
      autoload :Project,        'bugherd_client/resources/v2/project'
      autoload :Task,           'bugherd_client/resources/v2/task'
      autoload :Comment,        'bugherd_client/resources/v2/comment'
      autoload :Webhook,        'bugherd_client/resources/v2/webhook'
    end
  end

end
