# Notes: you will need to set your bugherd API_KEY as an ENV variable
# and you will need to sleep for 3 seconds between each request
# unless you contact BugHerd and get a token to avoid the rate limiting
# but only do this if you really need to make lots of requests for some reason.

$:.unshift File.expand_path('../../lib', __FILE__)

require 'bugherd_client'


# setup bugherd and use the latest version of the api
client = BugherdClient::Client.new(api_key: ENV['API_KEY'])

# get all webhooks
client.webhooks.all

# get a list of available webhook event types
events = client.webhooks.events

# create a new webhook
p = client.projects.all.first
new_webhook = client.webhooks.create({
  project_id: p.id, # this is optional
  event: 'create_task',
  target_url: 'https://someurl.com'
})

# delete a webhook
client.webhooks.delete(new_webhook.id)
