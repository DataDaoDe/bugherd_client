require 'spec_helper'
require 'http_helper'


describe(BugherdClient::Resources::V2::Organization) do

  let(:client) do
    client = BugherdClient::Client.new(api_key: 'testing')
  end

  context 'all', vcr: { cassette_name: "webhooks_all", record: :new_episodes } do

    it 'should return a list of webhooks' do
      response = client.webhooks.all
      expect(response).to    be_an(Array)
    end

  end

end
