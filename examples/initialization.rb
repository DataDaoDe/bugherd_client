# Notes: your will need to set your bugherd API_KEY as an ENV variable

$:.unshift File.expand_path('../../lib', __FILE__)

require 'bugherd_client'

# setup bugherd and use the latest version of the api
client = BugherdClient::Client.new(api_key: ENV['API_KEY'])

client = BugherdClient::Client.new(
  api_key: ENV['API_KEY'],
  api_version: 1, # use another version of the api
  api_rate_limiting_token: 'token', # set to avoid api rate limiting - contact bugherd
  debug: true, # debug http request/response cycles
)

# using block syntax
client = BugherdClient::Client.new do |c|
  c.username = 'theuser'
  c.password = 'thepass'
end
