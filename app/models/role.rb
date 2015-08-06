class Role
  include Mongoid::Document

  field :name, type: String
  field :removable, type: Boolean, default: true
  field :editable, type: Boolean, default: true
  field :default, type: Boolean, default: false

  belongs_to :project
  has_many :user_roles

  validates_presence_of :name

  def mark_as_default
    last_default = Role.find_by(project_id: self.project_id, default: true)
    last_default.update(default: false, removable: true)
    self.update(default: true, removable: false)
  end
end
