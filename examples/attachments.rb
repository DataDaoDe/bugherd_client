# Notes: you will need to set your bugherd API_KEY as an ENV variable
# and you will need to sleep for 3 seconds between each request
# unless you contact BugHerd and get a token to avoid the rate limiting
# but only do this if you really need to make lots of requests for some reason.

$:.unshift File.expand_path('../../lib', __FILE__)

require 'bugherd_client'

# setup bugherd and use the latest version of the api
client = BugherdClient::Client.new(api_key: ENV['API_KEY'])

# get all attachments for a task
p = client.projects.all.first
t = client.tasks.all(p.id).first

attachments = client.attachments.all(p.id, t.id)

# get a single attachment
client.attachments.find(p.id, t.id, 123)

# create a new attachment from an existing url
client.attachments.create(p.id, t.id, {
  file_name: 'example.txt',
  url: 'https://someurl.com/example.txt'
})

# upload a new attachment
new_attachment = client.attachments.upload(p.id, t.id, {
  file_name: 'test',
  data: File.open('/path/to/test.png', 'rb')
})

# delete an attachment
client.attachments.delete(p.id, t.id, new_attachment.id )
