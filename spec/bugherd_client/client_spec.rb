require 'spec_helper'


describe BugherdClient::Client do

  it "should list API_VERSIONS 1 and 2" do
    BugherdClient::Client::API_VERSIONS.should include(1)
    BugherdClient::Client::API_VERSIONS.should include(2)
  end

  context "default options" do
  
    it "should have a default api_version of 2" do
      BugherdClient::Client::DEFAULT_OPTIONS[:api_version].should eq(2)
    end

    it "should have an api_rate_limiting_token that defaults to x" do
      BugherdClient::Client::DEFAULT_OPTIONS[:api_rate_limiting_token].should eq('x')
    end

    it "should have a base_url with https as scheme and www.bugherd.com as host" do
      u = URI.parse(BugherdClient::Client::DEFAULT_OPTIONS[:base_url])
      u.scheme.should eq('https')
      u.host.should   eq('www.bugherd.com')
    end

  end

  context "#initialize" do
    it "should set options when taking a block" do
      client = BugherdClient::Client.new do |c|
        c.username = 'user'
        c.password = 'pass'
      end

      client.options[:username].should eq('user')
      client.options[:password].should eq('pass')
    end

    it "should create debug logging when the debug flag is set" do
      expect(RestClient.log).to eq(nil)
      client = BugherdClient::Client.new(api_key: 'apikey', debug: true)
      expect(RestClient.log.level).to eq(Logger::DEBUG)
    end
  end

  context "intialization errors" do
    it "should raise an error when no api_key or username and password is passed" do
      lambda do
        c = BugherdClient::Client.new
      end.should raise_error(BugherdClient::Errors::InvalidOption)
    end

    it "should raise an error when a username but no password is passed" do
      lambda do
        c = BugherdClient::Client.new(username: 'bob')
      end.should raise_error(BugherdClient::Errors::InvalidOption)
    end

    it "should raise an error when an invalid api_version is passed" do
      lambda do
        c = BugherdClient::Client.new(api_version: 99)
      end.should raise_error(BugherdClient::Errors::InvalidOption)
    end
  end

end