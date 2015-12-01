class Project
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :owner_id, type: BSON::ObjectId
  field :owner_username, type: String
  field :sprint_length, type: Integer, default: 14

  has_and_belongs_to_many :users
  has_many :roles, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :sprints, dependent: :destroy
  has_many :notebooks
  has_many :events
  has_many :stories

  validates_presence_of :name, :owner_id, :owner_username, :sprint_length

  def add_default_roles
    self.roles << Role.create(name: ProjectsHelper::PRODUCT_OWNER, removable: false, editable: false)
    self.roles << Role.create(name: ProjectsHelper::SCRUM_MASTER, removable: false, editable: false)
    self.roles << Role.create(name: ProjectsHelper::DEVELOPER, removable: false, editable: true, default: true)
  end
  
  def add_default_notebooks
    self.notebooks << Notebook.create(name: NotebooksHelper::TRASH, 
      description: NotebooksHelper::TRASH_DESCRIPTION, removable: false, default: false)
    self.notebooks << Notebook.create(name: NotebooksHelper::DEFAULT, 
      description: NotebooksHelper::DEFAULT_DESCRIPTION, removable: false, default: true)
  end
end
