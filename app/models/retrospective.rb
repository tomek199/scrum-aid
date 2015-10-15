class Retrospective
  include Mongoid::Document
  
  field :name, type: String
  field :date, type: Date
  
  belongs_to :sprint
  
  validates_presence_of :name
end
