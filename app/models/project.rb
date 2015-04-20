class Project
  include Mongoid::Document

  field :name, type: String
  field :description, type: String

  has_and_belongs_to_many :users

  validates_presence_of :name
end
