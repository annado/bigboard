class Initiative < ActiveRecord::Base
  belongs_to :manager, class_name: "Person"
  belongs_to :analyst, class_name: "Person"
  belongs_to :owner, class_name: "Person"
  belongs_to :security, class_name: "Person"
  has_many :projects
  belongs_to :board

  validates :name, presence: { message: "Please specify a name"}
  validates :board_id, presence: true

  has_paper_trail :meta => { :board_id  => :board_id }

  def ongoing_projects
    self.projects.where.not(completed: true).order(:start_date, created_at: :asc)
  end
end
