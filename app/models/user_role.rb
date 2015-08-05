class UserRole
  include Mongoid::Document

  belongs_to :project
  belongs_to :user
  belongs_to :role
end
