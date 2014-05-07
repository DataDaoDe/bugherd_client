require 'logger'

module BugherdClient
  class Client

    DEFAULT_OPTIONS = {
      base_url: 'https://www.bugherd.com',
      api_version: 2,
      username: '',
      password: '',
      api_key: '',
      debug: false
    }

    attr_accessor :options, :connection

    def initialize(options={}, &block)
      @options = DEFAULT_OPTIONS.merge(options)
      yield(self) if block_given?
      establish_connection!
    end

    def establish_connection!
      check_options!
      username, password = build_credentials
      
      if @options[:debug]
        RestClient.log = ::Logger.new($stderr)
        RestClient.log.level = Logger::DEBUG
      end

      self.connection = RestClient::Resource.new(base_url, user: username, password: password)
      
    end
    
    def base_url
      File.join(options[:base_url], "api_v#{options[:api_version]}")
    end

    def check_options!
      if !@options[:api_key] && !(@options[:username] && @options[:password])
        raise BugherdClient::Errors::InvalidOption, "api_key or username and password is required"
      end
    end

    def build_credentials
      if @options[:api_key]
        [@options[:api_key], 'x']
      else
        [@options[:username], @options[:password]]
      end
    end

    def resource(name, opts={})
      klass = Object.const_get("BugherdClient::Resources::#{name.to_s.capitalize}")
      klass.new(self.connection, self.options)
    end

    # 
    # Resources
    # 
    def organizations
      resource(:organization)
    end

    def users
      resource(:user)
    end

  end
end