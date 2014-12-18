require 'spec_helper'
require 'http_helper'

describe(BugherdClient::Resources::V2::Project) do

  let(:client) do
    client = BugherdClient::Client.new(api_key: 'testing')
  end
  let(:project_id) { 40093 }

  context 'priorities' do
    it 'should return a list of available task priorities' do
      priorities = client.tasks.priorities
      ['not set', 'critical', 'important', 'normal','minor'].each do |p|
        expect(priorities).to include(p)
      end
    end
  end

  context 'statuses' do
    it 'should return a list of available task statuses' do
      statuses = client.tasks.statuses
      ['backlog','todo','doing','done','closed'].each do |s|
        expect(statuses).to include(s)
      end
    end
  end

  context 'all', vcr: { cassette_name: 'tasks_all', record: :new_episodes } do
    it 'should return a list of tasks in a project' do
      tasks = client.tasks.all(project_id)
      expect(tasks).to be_an(Array)
      expect(tasks.count).to eq(7)
      t = tasks.first

      expect(t).to            have_key(:id)
      expect(t).to            have_key(:created_at)
      expect(t).to            have_key(:updated_at)
      expect(t).to            have_key(:local_task_id)
      expect(t).to            have_key(:priority_id)
      expect(t).to            have_key(:assigned_to_id)
      expect(t).to            have_key(:status_id)
      expect(t).to            have_key(:description)
      expect(t).to            have_key(:tag_names)
      expect(t.tag_names).to  be_an(Array)
      expect(t).to            have_key(:external_id)
      expect(t).to            have_key(:requester_id)
      expect(t).to            have_key(:requester_email)
    end
  end

  context 'find_success', vcr: { cassette_name: 'tasks_find_success', record: :new_episodes } do
    let(:task_id) { 1035995 }
    it 'should return a task when it exists' do
      t = client.tasks.find(project_id, task_id)

      expect(t).to  have_key(:id)
      expect(t).to  have_key(:created_at)
      expect(t).to  have_key(:updated_at)
      expect(t).to  have_key(:priority)
      expect(t).to  have_key(:status)
    end
  end

  context 'update', vcr: { cassette_name: 'tasks_update', record: :new_episodes } do
    let(:task_id) { 1035995 }
    it 'should update an existing task' do
      t = client.tasks.update(project_id, task_id, { status: 'doing' })

      expect(t).to  have_key(:id)
      expect(t).to  have_key(:status)
      expect(t.status).to eq('doing')
    end
  end

  context 'create', vcr: { cassette_name: 'tasks_create', record: :new_episodes } do
    let(:user_id) { 50190 }
    it 'should return a task when it exists' do
      description = 'A Test Task for Testing Tests'
      payload = {
          status: 'backlog',
          description: description,
          priority: 'normal',
          requester_id: user_id
      }
      t = client.tasks.create(project_id, payload)

      expect(t).to              have_key(:id)
      expect(t).to              have_key(:created_at)
      expect(t).to              have_key(:updated_at)
      expect(t).to              have_key(:local_task_id)
      expect(t).to              have_key(:priority_id)
      expect(t).to              have_key(:status_id)
      expect(t).to              have_key(:description)
      expect(t.description).to  eq(description)
      expect(t).to              have_key(:tag_names)
      expect(t.tag_names).to    be_an(Array)
      expect(t).to              have_key(:external_id)
      expect(t).to              have_key(:requester)
      expect(t.requester).to    be_a(Hash)
    end
  end

end
