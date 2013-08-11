require_relative '../lib/encryption_key.rb'
require_relative '../lib/decrypt.rb'
require_relative '../lib/content.rb'

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.mock_with :mocha
end