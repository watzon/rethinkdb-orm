require "active-model"

require "./associations"
require "./connection"
require "./index"
require "./persistence"
require "./queries"
require "./table"

require "./validators/*"

abstract class RethinkORM::Base < ActiveModel::Model
  include ActiveModel::Validation
  include ActiveModel::Callbacks

  include Associations
  include Index
  include Persistence
  include Table
  include Validators

  extend Queries

  TABLES  = [] of String
  INDICES = [] of NamedTuple(field: String, table: String)

  macro inherited
    macro finished
      __process_table__
    end
  end

  # Default primary key
  attribute id : String

  # TODO: Is this the best way to do this?
  def_equals attributes, changed_attributes
end
