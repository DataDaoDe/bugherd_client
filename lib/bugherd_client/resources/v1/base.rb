require 'json'

module BugherdClient
  module Resources
    module V1

      class Base

        DEFAULT_HEADER_ATTRS = {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }.freeze

        #
        # Return a list of available methods in a Resource
        #
        def api_methods
          self.class.instance_methods(false)
        end

        attr_accessor :connection, :options
        def initialize(conn, opts={})
          @connection, @options = conn, opts
        end

        def send_request(method='GET', path='', params={}, headers={})
          headers = DEFAULT_HEADER_ATTRS.merge(headers)
          params.merge!(headers)
          method_name = method.to_s.downcase
          self.connection[path].__send__(method_name, params)
        end

        [:get, :post, :put, :patch, :delete].each do |method_name|
          define_method("#{method_name}_request") do |path, params={}|
            send_request(method_name, path, params)
          end
        end

        def parse_response(response, root_element=nil)
          if root_element
            pr = JSON.parse(response)
            if pr.is_a?(Hash) and pr.has_key?(root_element)
              pr[root_element]
            else
              pr
            end
          else
            JSON.parse(response)
          end
        end
      end

    end
  end
end
