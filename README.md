[![Gem Version](https://badge.fury.io/rb/bugherd_client.svg)](http://badge.fury.io/rb/bugherd_client)
[![Dependency Status](https://gemnasium.com/jwaterfaucett/bugherd_client.svg)](https://gemnasium.com/jwaterfaucett/bugherd_client)
[![Build Status](https://travis-ci.org/jwaterfaucett/bugherd_client.svg?branch=master)](https://travis-ci.org/jwaterfaucett/bugherd_client)


# BugHerd Client

This is a Rest Client for the BugHerd API. It fully covers all methods of the v1 and v2 API Implementations.
Another nifty feature is that its threadsafe so you could potentially have many instances floating around and don't
have to worry about collisions as is the case with ActiveResource.

## Installation

Add this line to your application's Gemfile:

    gem 'bugherd_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bugherd_client

## Basic Usage

```ruby

# create a client from an api_key, it will automatically use the latest version of the BugHerd API (currently v2)
client = BugherdClient::Client.new(api_key: 'someapikey')

# or you can create the client using block syntax
client = BugherdClient::Client.new do |c|
  c.username = 'user'
  c.password = 'pass'
end

# Get information about your organization
client.organization.get # => returns your organization information

# Get a list of all users
all_users = client.users.all # => returns a list of all users
user = all_users.first

# Find a specific project
project = client.projects.find(1023)

# Create a new Task
task = client.tasks.create(project[:id], {
  description: 'This is a description',
  requester_id: user[:id],
  status: 'backlog',
  priority: 'normal'
})

# Create a comment
client.comments.create(project[:id], task[:id], {
  text: 'hey this is a comment'
})

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/bugherd_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
