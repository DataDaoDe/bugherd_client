# Notes: you will need to set your bugherd API_KEY as an ENV variable
# and you will need to sleep for 3 seconds between each request
# unless you contact BugHerd and get a token to avoid the rate limiting
# but only do this if you really need to make lots of requests for some reason.

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
