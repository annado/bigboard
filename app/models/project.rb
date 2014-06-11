class Project < ActiveRecord::Base
  has_paper_trail :meta => { :board_id  => :board_identifier }
  
  belongs_to :initiative
  has_many :project_members, :dependent => :destroy
  has_many :members, :through => :project_members, :source => :person

  validates :name, presence: { message: "Please specify a name"}
  validates :initiative_id, presence: { message: "Initiative required"}
  validates :project_type, presence: { message: "Project type required"}

  def board_identifier
    self.initiative.board.id
  end
end
