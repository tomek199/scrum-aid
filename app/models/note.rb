class Note
  include Mongoid::Document
  
  field :text, type: String
  field :created_at, type: DateTime, default: DateTime.now
  field :created_by, type: String
  
  embedded_in :notebook
  
  validates_presence_of :text, :created_at, :created_by
end
