class Story
  include Mongoid::Document
  
  field :title, type: String
  field :summary, type: String
  field :index, type: Integer
  field :points, type: Integer
  field :created_at, type: DateTime
  field :created_by, type: String
  field :updated_at, type: DateTime
  field :updated_by, type: String
  
  belongs_to :sprint
  
  validates_presence_of :title, :index, :created_at, :created_by
end
