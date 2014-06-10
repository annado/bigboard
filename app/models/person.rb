class Person < ActiveRecord::Base
  has_paper_trail :meta => { :board_id  => :board_id }
  belongs_to :team
  belongs_to :board
  has_many :projects, :through => :project_members
  has_many :project_members

  validates :name, presence: { message: "Please specify a name"}
  validates :team, presence: true
  validates_uniqueness_of :uid, scope: [:board_id], presence: { message: "Unique UID is required"}

  searchkick autocomplete: ['name']

  def active_projects
    self.projects.where(:completed => false)
  end

  def active_project_count
    self.active_projects.size
  end

end
