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

  end
end