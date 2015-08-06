class Role
  include Mongoid::Document

  field :name, type: String
  field :removable, type: Boolean, default: true
  field :editable, type: Boolean, default: true
  field :default, type: Boolean, default: false

  belongs_to :project
  has_many :user_roles

  validates_presence_of :name
end
