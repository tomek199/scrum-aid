class Role
  include Mongoid::Document

  field :name, type: String

  belongs_to :project

  validates_presence_of :name
end
