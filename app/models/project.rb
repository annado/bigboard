class Project < ActiveRecord::Base
  has_paper_trail :meta => { :board_id  => :board_identifier }, :ignore => [:notes, :updated_at]

  belongs_to :initiative
  belongs_to :location
  has_many :project_members, :dependent => :destroy
  has_many :members, :through => :project_members, :source => :person

  validates_presence_of :name, :initiative_id, :location, :project_description
  validates_presence_of :product_spec, :yammer_group, :if => :not_standing?

  def board_identifier
    self.initiative.board.id
  end

  def active_project_members_for_role role_id
    self.project_members.where("role_id = ? AND (end_date >= ? OR end_date IS NULL)", role_id, Date.today).order(:start_date)
  end

  def vacation?
    self.name == "Vacation"
  end

  def not_standing?
    !self.initiative.standing?
  end
end
