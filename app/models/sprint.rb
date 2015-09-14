class Sprint
  include Mongoid::Document

  field :name, type: String
  field :index, type: Integer
  field :start_date, type: DateTime
  field :end_date, type: DateTime
  field :current, type: Boolean, default: false
  field :goal, type: String

  belongs_to :project

  validates_presence_of :name, :index, :start_date, :end_date

  def generate_index
    self.index = self.project.sprints.size
  end

end
