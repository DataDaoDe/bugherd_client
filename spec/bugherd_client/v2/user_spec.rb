require 'spec_helper'
require 'http_helper'

describe(BugherdClient::Resources::V2::User) do

  let(:client) do
    client = BugherdClient::Client.new(api_key: 'testing')
  end

  context 'all', vcr: { cassette_name: 'users_all', record: :new_episodes } do
    it 'should return a list of all users in an organization' do
      users = client.users.all
      expect(users).to be_an(Array)

      u = users.first
      expect(u).to  have_key(:id)
      expect(u).to  have_key(:email)
      expect(u).to  have_key(:display_name)
      expect(u).to  have_key(:avatar_url)
    end
  end

  context 'members', vcr: { cassette_name: 'members_all', record: :new_episodes } do
    it 'should return a list of all members in an organization' do
      members = client.users.members
      expect(members).to be_an(Array)

      m = members.first

      expect(m).to  have_key(:id)
      expect(m).to  have_key(:email)
      expect(m).to  have_key(:display_name)
      expect(m).to  have_key(:avatar_url)
    end
  end

  context 'guests', vcr: { cassette_name: 'guests_all', record: :new_episodes } do
    it 'should return a list of all guests in an organization' do
      guests = client.users.guests
      expect(guests).to be_an(Array)

      g = guests.first

      expect(g).to  have_key(:id)
      expect(g).to  have_key(:email)
      expect(g).to  have_key(:display_name)
      expect(g).to  have_key(:avatar_url)
    end
  end
end
