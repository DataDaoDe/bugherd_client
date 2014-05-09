require 'logger'

module BugherdClient
  class Client

    API_VERSIONS = [1,2].freeze

    DEFAULT_OPTIONS = {
      base_url: 'https://www.bugherd.com',
      api_version: 2,
      username: nil,
      password: nil,
      api_key: nil,
      api_rate_limiting_token: 'x',
      debug: false
    }.freeze

    attr_accessor :options, :connection

    DEFAULT_OPTIONS.each do |option_name, v|
      define_method("#{option_name}") { @options[option_name] }
      define_method("#{option_name}=") { |value| @options[option_name] = value }
    end

    def initialize(opts={}, &block)
      @options = DEFAULT_OPTIONS.merge(opts)
      yield(self) if block_given?
      establish_connection!
    end

    def establish_connection!
      check_options!
      username, password = build_credentials
      
      if @options[:debug]
        RestClient.log        = ::Logger.new($stderr)
        RestClient.log.level  = ::Logger::DEBUG
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
      unless API_VERSIONS.include?(@options[:api_version])
        raise BugherdClient::Errors::InvalidOption, "api_version must be #{API_VERSIONS.join(',')}"
      end
    end

    def build_credentials
      if @options[:api_key].present?
        [@options[:api_key], @options[:api_rate_limiting_token]]
      else
        [@options[:username], @options[:password]]
      end
    end

    def resource(name)
      version = self.options[:api_version]
      version_base = "BugherdClient::Resources::V#{version}".constantize
      klass_name   = name.to_s.classify.to_sym
      unless version_base.constants.include?(klass_name)
        raise BugherdClient::Errors::NotAvailable, version, klass_name
      end
      klass = version_base.const_get(klass_name)
      klass.new(self.connection, @options)
    end

    # 
    # Resources
    # 
    [:organization, :user, :project, :task, :comment].each do |resource_name|
      define_method("#{resource_name.to_s.pluralize}") do
        resource("#{resource_name}")
      end
    end

  end
end