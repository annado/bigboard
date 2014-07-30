class Person < ActiveRecord::Base
  include ApplicationHelper
  has_paper_trail :meta => { :board_id  => :board_id }
  belongs_to :team
  belongs_to :board
  belongs_to :location
  has_many :project_members, -> { where ["project_members.start_date <= ? AND (project_members.end_date >= ? OR project_members.end_date IS NULL)", Date.today, Date.today] }, dependent: :destroy
  has_many :projects, :through => :project_members
  validates :name, presence: { message: "Please specify a name"}
  validates :team, presence: true
  validates_uniqueness_of :uid, scope: [:board_id], presence: { message: "Unique UID is required"}

  searchkick autocomplete: ['name']

  def active_projects
    self.projects.where("projects.completed = ? AND projects.start_date <= ?", false, Date.today)
  end

  def active_project_count
    self.active_projects.size
  end

  def allocated_to type
    self.active_projects.first.project_type == type unless self.active_project_count == 0
  end

  def allocated_to_internal_initiative
    self.active_projects.first.initiative.name == 'Internal Projects' unless self.active_project_count == 0
  end

  def initiative_owner?
    self.board.initiatives.any? do |i|
      i.owner == self
    end
  end

  def on_standing_initiative?
    self.projects.any? do |proj|
      proj.initiative.standing
    end
  end

  def freeing_up_soon?
    if (self.project_members.count == 1 && self.project_members[0].end_date)
      nearing_deadline(self.project_members[0].end_date)
    end
  end

end
