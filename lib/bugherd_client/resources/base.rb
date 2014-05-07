require 'json'

module BugherdClient
  module Resources
    class Base
      attr_accessor :connection, :options
      def initialize(conn, opts={})
        @connection, @options = conn, opts
      end


      def send_request(method="GET", path="", params={})
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
          JSON.parse(response)[root_element.to_s]
        else
          JSON.parse(response)
        end
      end
    end
  end
end