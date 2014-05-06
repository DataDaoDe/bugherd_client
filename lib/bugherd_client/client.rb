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
      username, password_or_key = build_credentials
      self.connection = Her::API.new
      self.connection.setup(url: base_url) do |conn|
        conn.use Faraday::Request::UrlEncoded
        conn.headers['Content-Type'] = 'application/json'

        if username
          conn.use Faraday::Request::BasicAuthentication, username, password_or_key
        else
          conn.headers['Authorization'] = Base64.encode64(password_or_key).gsub("\n", '')
        end
        
        if self.options[:debug]
          conn.use BugherdClient::MonkeyPatch::Debugger, debug: self.options[:debug]
          conn.use Faraday::Response::Logger
        end

        conn.use Her::Middleware::DefaultParseJSON
        conn.use Faraday::Adapter::NetHttp
      end
    end


    def build_credentials
      if @options[:api_key]
        [false, @options[:api_key]]
      elsif @options[:username] && @options[:password]
        [@options[:username], @options[:password]]
      else
        # TODO: Error Handling
      end
    end
    
    def base_url
      File.join(options[:base_url], "api_v#{options[:api_version]}")
    end

    def resource(name, opts={})
      klass   = "BugherdClient::Resources::#{name.to_s.classify}".constantize
      the_api = self.connection
      Class.new(klass) do |c|
        c.use_api(the_api)
        c.parse_root_in_json(klass.parse_root_in_json)
        c.element_name(klass.name.to_s.underscore.to_sym)
        c.collection_path(klass.collection_path)
        c.resource_path(klass.resource_path)
      end
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