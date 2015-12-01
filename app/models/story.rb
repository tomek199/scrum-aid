class Story
  include Mongoid::Document
  
  field :title, type: String
  field :summary, type: String
  field :index, type: Integer
  field :points, type: Integer
  field :status, type: String, default: "open"
  field :created_at, type: DateTime, default: DateTime.now
  field :created_by, type: String
  field :updated_at, type: DateTime
  field :updated_by, type: String
  
  belongs_to :project
  
  validates_presence_of :title, :index, :created_at, :created_by
  
  def initialize(params = nil, project = nil, username = nil)
    super(params)
    self.created_by = username
    self.index = project.stories.count if project
    self.project = project
  end
end
