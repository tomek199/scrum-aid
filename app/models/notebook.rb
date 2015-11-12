class Notebook
  include Mongoid::Document
  
  field :name, type: String
  field :description, type: String
  field :removable, type: Boolean, default: true
  field :default, type: Boolean, default: false
  
  belongs_to :project
  embeds_many :notes
  
  validates_presence_of :name
  
  def mark_as_default
    last_default = Notebook.where(project_id: self.project_id, default: true)
    last_default.update(default: false, removable: true) if last_default.exists?
    self.update(default: true, removable: false)
  end
  
  def move_note_to_trash(note_id)
    trash = self.project.notebooks.where(removable: false, default: false).one
    note = self.notes.find(note_id)
    trash.notes.create(text: note.text, created_at: note.created_at, created_by: note.created_by)
    self.notes.delete(note)
  end
end
