[![Gem Version](https://badge.fury.io/rb/bugherd_client.svg)](http://badge.fury.io/rb/bugherd_client)
[![Dependency Status](https://gemnasium.com/jwaterfaucett/bugherd_client.svg)](https://gemnasium.com/jwaterfaucett/bugherd_client)
[![Build^ Status](https://travis-ci.org/jwaterfaucett/bugherd_client.svg?branch=master)](https://travis-ci.org/jwaterfaucett/bugherd_client)
[![Code Climate](https://codeclimate.com/github/jwaterfaucett/bugherd_client/badges/gpa.svg)](https://codeclimate.com/github/jwaterfaucett/bugherd_client)
[![Coverage Status](https://coveralls.io/repos/jwaterfaucett/bugherd_client/badge.png?branch=master)](https://coveralls.io/r/jwaterfaucett/bugherd_client?branch=master)


# BugHerd Client

This is a Rest Client for the BugHerd API.

**features:**

* Threadsafe
* Full V1 API support
* Full V2 API support

**ruby support:**

* JRuby
* Rubinius 2+
* MRI >= 1.9.3


## Installation

    $ gem install bugherd_client

## Basic Usage

For usage look in the examples folders. Examples are only kept for the latest
version of the API so if you really want to use older versions you'll have to
look at the source.

* [Setup](examples/initialization.rb)
* [Projects](examples/projects.rb)
* [Users & Organization](examples/users_and_organization.rb)
* [Task & Comments](examples/tasks_and_comments.rb)
* [Attachments](examples/attachments.rb)
* [Webhooks](examples/webhooks.rb)

## Contributing

Please note that all contributions require tests.

1. Fork it ( http://github.com/<my-github-username>/bugherd_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Write some tests.
6. Create new Pull Request
