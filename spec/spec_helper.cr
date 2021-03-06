require "spec"
require "faker"

require "../src/rethinkdb-orm"
require "../src/rethinkdb-orm/*"
require "../src/rethinkdb-orm/**"
require "./spec_models"

DB_NAME = "test_#{Time.utc.to_unix}_#{rand(10000)}"

Spec.before_suite do
  RethinkORM.configure do |settings|
    settings.db = DB_NAME
  end
  ::Log.setup("*", level: :debug)
end

Spec.after_suite do
  # Tear down the test database
  RethinkORM::Connection.raw do |q|
    q.db_drop(DB_NAME)
  end
end
