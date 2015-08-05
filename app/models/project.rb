class Project
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :owner_id, type: BSON::ObjectId
  field :owner_username, type: String

  has_and_belongs_to_many :users
  has_many :roles, dependent: :destroy
  has_many :user_roles, dependent: :destroy

  validates_presence_of :name, :owner_id, :owner_username

  def add_default_roles
    self.roles << Role.create(name: ProjectsHelper::PRODUCT_OWNER, removable: false, editable: false)
    self.roles << Role.create(name: ProjectsHelper::SCRUM_MASTER, removable: false, editable: false)
    self.roles << Role.create(name: ProjectsHelper::DEVELOPER, removable: false, editable: true)
  end
end
