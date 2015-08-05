class Role
  include Mongoid::Document

  field :name, type: String

  belongs_to :project
  has_many :user_roles

  validates_presence_of :name
end
