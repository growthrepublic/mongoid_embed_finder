$LOAD_PATH.unshift(File.join(__dir__, "..", "lib"))

require "mongoid"
require "rspec/its"

# These environment variables can be set if wanting to test against a database
# that is not on the local machine.
ENV["MONGOID_SPEC_HOST"] ||= "localhost"
ENV["MONGOID_SPEC_PORT"] ||= "27017"

# These are used when creating any connection in the test suite.
HOST = ENV["MONGOID_SPEC_HOST"]
PORT = ENV["MONGOID_SPEC_PORT"].to_i

def database_id
  "mongoid_test"
end

CONFIG = {
  sessions: {
    default: {
      database: database_id,
      hosts: [ "#{HOST}:#{PORT}" ]
    }
  }
}

# Set the database that the spec suite connects to.
Mongoid.configure do |config|
  config.load_configuration(CONFIG)
end

class Door
  include Mongoid::Document
  field :name, type: String
  embedded_in :car
end unless defined?(Door)

class Car
  include Mongoid::Document
  field :name, type: String
  embeds_many :doors
end unless defined?(Car)

RSpec.configure do |config|
  config.raise_errors_for_deprecations!

  # Drop all collections and clear the identity map before each spec.
  config.before(:each) do
    Mongoid.purge!
  end
end