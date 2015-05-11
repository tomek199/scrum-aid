class Project
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :owner_id, type: BSON::ObjectId
  field :owner_username, type: String

  has_and_belongs_to_many :users

  validates_presence_of :name, :owner_id, :owner_username
end
