# BugherdClient

This is a Rest Client for the Bugherd API. It fully covers all methods of the v1 and v2 API Implementations.
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

client = BugherdClient::Client.new(api_key: 'someapikey', api_version: 2) # api_version 2 is the default
client.organization.get # => returns your organization information
client.users.all # => returns a list of all users
project = client.projects.find(1023)
user = client.users.all.first

client.tasks.create(project[:id], {
  description: 'Some description',
  requester_id: user[:id],
  status: BugherdClient::Resources::Task::STATUS_BACKLOG,
  priority: BugherdClient::Resources::Task::PRIORITY_NORMAL,
  external_id: 'my-external-app-123'
})



```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/bugherd_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
