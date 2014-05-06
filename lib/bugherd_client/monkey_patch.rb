Faraday::Adapter::NetHttp.class_eval do
  def net_http_connection(env)
    http_conn = if proxy = env[:request][:proxy]
      Net::HTTP::Proxy(proxy[:uri].host, proxy[:uri].port, proxy[:user], proxy[:password])
    else
      Net::HTTP
    end.new(env[:url].host, env[:url].port)
    http_conn.set_debug_output($stdout) if env[:debug]
    http_conn
  end
end

module BugherdClient
  module MonkeyPatch
    class Debugger < Faraday::Middleware

      def initialize(app = nil, options = {})
        super(app)
        @app, @options = app, options        
      end
      
      def call(env)
        env[:debug] = true if @options[:debug]
        @app.call(env)
      end

    end
  end
end