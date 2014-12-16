require 'spec_helper'
require 'http_helper'

describe(BugherdClient::Resources::V2::Project) do

  let(:client) do
    client = BugherdClient::Client.new(api_key: 'testing')
  end
  let(:project_id) { 40093 }

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
end
