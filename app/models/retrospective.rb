class Retrospective
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  
  field :name, type: String
  field :date, type: Date
  
  belongs_to :sprint
  
  validates_presence_of :name
end
