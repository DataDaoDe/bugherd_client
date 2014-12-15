require 'spec_helper'

describe(BugherdClient::Client) do
  let(:client_klass) { BugherdClient::Client }
  context 'supported_versions' do

    it 'should list API_VERSIONS 1 and 2' do
      expect(BugherdClient::Client::API_VERSIONS).to eq([1,2])
    end

  end

  context 'default_options' do
    it 'should have a default api_version of 2' do
      expect(client_klass::DEFAULT_OPTIONS[:api_version]).to eq(2)
    end


    it 'should have an api_rate_limiting_token that defaults to x' do
      expect(client_klass::DEFAULT_OPTIONS[:api_rate_limiting_token]).to eq('x')
    end

    it 'should have a base_url with https as scheme and www.bugherd.com as host' do
      u = URI.parse(client_klass::DEFAULT_OPTIONS[:base_url])
      expect(u.scheme).to eq('https')
      expect(u.host).to eq('www.bugherd.com')
    end

  end

  context '#initialize' do
    it 'should set options when taking a block' do
      client = BugherdClient::Client.new do |c|
        c.username = 'user'
        c.password = 'pass'
        c.api_key  = 'foo'
        c.debug    = false
      end

      expect(client.options[:username]).to  eq('user')
      expect(client.options[:password]).to  eq('pass')
      expect(client.options[:api_key]).to   eq('foo')
      expect(client.options[:debug]).to     eq(false)
    end

    it 'should create debug logging when the debug flag is set' do
      expect(RestClient.log).to eq(nil)
      client = BugherdClient::Client.new(api_key: 'apikey', debug: true)
      expect(RestClient.log.level).to eq(Logger::DEBUG)
    end
  end

  context 'initialization_errors' do

    it 'should raise an error when no api_key or username and password is passed' do
      expect {
        c = BugherdClient::Client.new
      }.to raise_error(BugherdClient::Errors::InvalidOption)
    end

    it 'should raise an error when a username but no password is passed' do
      expect {
        c = BugherdClient::Client.new(username: 'bob')
      }.to raise_error(BugherdClient::Errors::InvalidOption)
    end

    it 'should raise an error when an invalid api_version is passed' do
      expect {
        c = BugherdClient::Client.new(api_version: 99)
      }.to raise_error(BugherdClient::Errors::InvalidOption)
    end
  end

end
