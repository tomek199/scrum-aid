class Event
  include Mongoid::Document
  
  field :title, type: String
  field :description, type: String
  field :start, type: DateTime
  field :end, type: DateTime
  field :allDay, type: Boolean, default: false
  field :editable, type: Boolean, default: true
  field :color, type: String, default: "blue"
  
  belongs_to :project
  
  validates_presence_of :title, :start
end
