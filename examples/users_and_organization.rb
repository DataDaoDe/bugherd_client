# Notes: your will need to set your bugherd API_KEY as an ENV variable

$:.unshift File.expand_path('../../lib', __FILE__)
require 'bugherd_client'

client = BugherdClient::Client.new(api_key: ENV['API_KEY'])

# get your organization info
client.organizations.get

# get all your users
client.users.all

# get all organization members
client.users.members

# get all organization guests
client.users.guests
