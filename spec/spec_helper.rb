# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

lib = File.expand_path('../../lib', __FILE__)
support = File.expand_path('../support', __FILE__)
[lib, support].each { |path| $:.unshift(path) unless $:.include?(path) }
require 'pry'

require 'coveralls'
require 'simplecov'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter '/spec/'
  add_group  'api_v1', 'bugherd_client/resources/v1'
  add_group  'api_v2', 'bugherd_client/resources/v2'
end

require 'bugherd_client'

RSpec.configure do |config|

  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Use expext(...).to  syntax
  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random
  Kernel.srand(config.seed)

  # Show the 10 slowest tests
  config.profile_examples = 10
end
