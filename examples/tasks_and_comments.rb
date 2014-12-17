# Notes: you will need to set your bugherd API_KEY as an ENV variable
# and you will need to sleep for 3 seconds between each request
# unless you contact BugHerd and get a token to avoid the rate limiting
# but only do this if you really need to make lots of requests for some reason.

$:.unshift File.expand_path('../../lib', __FILE__)

require 'bugherd_client'

# setup bugherd and use the latest version of the api
client = BugherdClient::Client.new(api_key: ENV['API_KEY'])

# get a project
projects = client.projects.all
p = projects.first

# get all tasks for a project
client.tasks.all(p.id)

# get a list of available statuses and priorities
client.tasks.statuses
client.tasks.priorities

# filter tasks by attributes:
# updated_since, created_since, status, priority, tag, assigned_to_id and external_id.
client.tasks.all(p.id, status:  'backlog')
client.tasks.all(p.id, priority: 'important')
client.tasks.all(p.id, updated_since: DateTime.new(2014, 9).iso8601 )
client.tasks.all(p.id, tag: 'mytag', created_since: DateTime.new(2014).iso8601 )

# find a single task
task_id = 1234
client.tasks.find(p.id, task_id)

# update a task
client.tasks.update(p.id, task.id, description: 'A Description', priority: 'critical')

# create a task
user = client.users.first
new_task = client.tasks.create(p.id, {
  status: 'backlog',
  description: 'Just found a bug',
  priority: 'normal',
  requester_id: user.id
})

# add a comment to a task
client.comments.create(p.id, new_task.id, {
    text: 'This is a comment',
    user_id: user.id
})

# list comments
client.comments.all(p.id, new_task.id)
