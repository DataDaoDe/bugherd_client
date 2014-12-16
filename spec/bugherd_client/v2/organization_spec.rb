require 'spec_helper'
require 'http_helper'


describe(BugherdClient::Resources::V2::Organization) do

  let(:client) do
      client = BugherdClient::Client.new(api_key: 'testing')
  end

  context 'get', vcr: { cassette_name: "organizations_get", record: :new_episodes } do

    it 'should return the id and name of the organization' do
      response = client.organizations.get
      expect(response.id).to    eq(21203)
      expect(response.name).to  eq('testCloud')
    end

  end

end
