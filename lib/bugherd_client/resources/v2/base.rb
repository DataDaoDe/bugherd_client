require 'json'

module BugherdClient
  module Resources
    module V2

      class Base

        DEFAULT_HEADER_ATTRS = {
          :content_type => :json,
          :accept => :json
        }.freeze

        #
        # Return a list of available methods in a Resource
        #
        def api_methods
          self.class.instance_methods(false)
        end

        # store a reference to the HTTP connection
        attr_accessor :connection

        attr_accessor :options

        def initialize(conn, opts={})
          @connection, @options = conn, opts
        end

        def send_request(method='GET', path='', params={}, headers={})
          headers = DEFAULT_HEADER_ATTRS.merge(headers)
          params.merge!(headers)
          method_name = method.to_s.downcase
          self.connection[path].__send__(method_name, params)
        rescue RestClient::Exception => e
          raise(BugherdClient::Errors::HttpRequestError.new(e.message, e.http_code))
        end

        [:get, :post, :put, :patch, :delete].each do |method_name|
          define_method("#{method_name}_request") do |path, params={}|
            send_request(method_name, path, params)
          end
        end

        def converter(body)
          case body
          when Hash
            ::Hashie::Mash.new(body)
          when Array
            body.map { |item| item.is_a?(Hash) ? converter(item) : item }
          else
            body
          end
        end

        def parse_response(response, root_element=nil)
          parsed = if root_element
            p = JSON.parse(response)
            p.key?(root_element.to_s) ? p[root_element.to_s] : p
          else
            JSON.parse(response)
          end
          converter(parsed)
        end

      end

    end
  end
end
