# Notes: you will need to set your bugherd API_KEY as an ENV variable
# and you will need to sleep for 3 seconds between each request
# unless you contact BugHerd and get a token to avoid the rate limiting
# but only do this if you really need to make lots of requests for some reason.

$:.unshift File.expand_path('../../lib', __FILE__)

require 'bugherd_client'

# setup bugherd and use the latest version of the api
client = BugherdClient::Client.new(api_key: ENV['API_KEY'])

# get all projects
projects = client.projects.all

# get all active projects
client.projects.active

# find a project by its id
client.projects.find(projects.first.id)

# create a new project
new_project = client.projects.create(
  name: 'TestProject',
  devurl: 'https://testproject.com'
)

# update a project
client.projects.update(new_project.id, name: 'TestProject_Updated')

# add a member to a project
client.projects.add_member(new_project.id, user_id: 123)

# add a guest to a project
client.projects.add_guest(new_project.id, user_id: 456, email: 'test@test.com')

# delete a project
client.projects.delete(new_project.id)
