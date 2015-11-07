class Notebook
  include Mongoid::Document
  
  field :name, type: String
  field :description, type: String
  field :removable, type: Boolean, default: true
  field :default, type: Boolean, default: false
  
  belongs_to :project
  
  validates_presence_of :name
end
