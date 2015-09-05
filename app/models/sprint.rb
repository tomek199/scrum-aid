class Sprint
  include Mongoid::Document

  field :name, type: String
  field :start_date, type: DateTime
  field :end_date, type: DateTime
  field :current, type: Boolean, default: false
  field :goal, type: String

  belongs_to :project

  validates_presence_of :name, :start_date, :end_date

end
