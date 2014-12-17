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
  context 'create', vcr: { cassette_name: 'projects_create', record: :new_episodes } do
    it 'should create a project and return it' do
      payload = {
        name: 'TestProject',
        devurl: 'https://testproject.com'
      }
      p = client.projects.create(payload)
      expect(p).to have_key(:id)
      expect(p).to have_key(:devurl)
      expect(p).to have_key(:api_key)
      expect(p).to have_key(:is_public)
      expect(p).to have_key(:is_active)
      expect(p).to have_key(:members)
      expect(p).to have_key(:guests)

      # types
      expect(p.id).to be_an(Integer)
      expect(p.members).to  be_an(Array)
      expect(p.guests).to   be_an(Array)
    end
  end
  context 'update', vcr: { cassette_name: 'projects_update', record: :new_episodes } do
    it 'should update an existing project and return it' do
      new_devurl = 'https://example.com'
      existing_p = client.projects.all.first
      updated_p = client.projects.update(existing_p.id, {
        devurl: new_devurl
      })
      expect(updated_p.devurl).to eq(new_devurl)
    end
  end

  context 'delete', vcr: { cassette_name: 'projects_delete', record: :new_episodes } do
    it 'should update an existing project and return it' do
      existing_project_id = 59745
      existing_p = client.projects.find(existing_project_id)
      res = client.projects.delete(existing_p.id)
      expect(res).to have_key(:success)
      expect(res.success).to eq(true)
    end
  end

end
