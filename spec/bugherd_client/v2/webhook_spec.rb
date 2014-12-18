require 'spec_helper'
require 'http_helper'


describe(BugherdClient::Resources::V2::Organization) do

  let(:client) do
    client = BugherdClient::Client.new(api_key: 'testing')
  end

  context 'events' do
    it 'should return a list of available webhook events' do
      event_list = client.webhooks.events
      ['task_create', 'task_update', 'task_destroy', 'comment'].each do |e|
        expect(event_list).to include(e)
      end
    end
  end

  context 'all', vcr: { cassette_name: "webhooks_all", record: :new_episodes } do

    it 'should return a list of webhooks' do
      response = client.webhooks.all
      expect(response).to    be_an(Array)
    end

  end

  context 'create', vcr: { cassette_name: "webhooks_create", record: :new_episodes } do

    it 'should create new webhook' do
      payload = { target_url: 'https://www.example.comfoocom.io', event: 'task_create' }
      response = client.webhooks.create(payload)

      expect(response).to have_key(:id)
      expect(response).to have_key(:target_url)
      expect(response).to have_key(:event)
      expect(response).to have_key(:success_count)
      expect(response).to have_key(:project_id)
    end

  end


  context 'create', vcr: { cassette_name: "webhooks_delete", record: :new_episodes } do
    let(:webhook_id) { 4141 }

    it 'should delete an existing webhook' do
      response = client.webhooks.delete(webhook_id)

      expect(response).to         have_key(:success)
      expect(response.success).to eq(true)
    end

  end
end
