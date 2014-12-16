require 'spec_helper'
require 'http_helper'

describe(BugherdClient::Resources::V2::Project) do

  let(:client) do
    client = BugherdClient::Client.new(api_key: 'testing')
  end

  context 'all', vcr: { cassette_name: "projects_all", record: :new_episodes } do
    it 'should return a list of projects containing id and name' do
      response = client.projects.all
      expect(response).to    be_an(Array)
      expect(response.count).to eq(2)

      p1 = response.first
      expect(p1.id).to eq(40093)
      expect(p1.name).to eq('MyTestProject')
    end
  end

  context 'find_success', vcr: { cassette_name: "projects_find_success", record: :new_episodes } do
    it 'should return a project when the project exists' do
      response = client.projects.find(40093)

      expect(response.id).to        eq(40093)
      expect(response.name).to      eq('MyTestProject')
      expect(response.devurl).to    be_a(String)
      expect(response.api_key).to   be_a(String)
      expect(response.is_active).to eq(true)
      expect(response.members).to   be_an(Array)
      expect(response.guests).to    be_an(Array)

      m = response.members.first
      expect(m.id).to             eq(50190)
      expect(m.display_name).to   eq('John Faucett')

      g = response.guests.first
      expect(g.id).to             eq(50536)
      expect(g.display_name).to   eq('tilman.bahls@testcloud.de')
    end
  end

  context 'find_failure', vcr: { cassette_name: "projects_find_failure", record: :new_episodes } do
    it 'should raise an error when project does not exist' do
      expect {
        client.projects.find(1)
      }.to raise_error(BugherdClient::Errors::HttpRequestError, /404 Resource Not Found/)
    end
  end

  context 'active', vcr: { cassette_name: "projects_active", record: :new_episodes } do
    it 'should return all active projects' do
      response  = client.projects.active

      expect(response).to    be_an(Array)
      expect(response.count).to eq(2)

      p1 = response.first
      expect(p1.id).to eq(40093)
      expect(p1.name).to eq('MyTestProject')
    end
  end


end
