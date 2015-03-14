class User
  include Mongoid::Document

  field :name, type: String
  field :last_name, type: String
end