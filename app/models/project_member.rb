class ProjectMember < ActiveRecord::Base
  has_paper_trail :meta => { :board_id  => :board_identifier }
  validates :project_id, presence: { message: "Requires project"}
  validates :person_id, presence: { message: "Requires person"}
  belongs_to :project
  belongs_to :person
  belongs_to :role

  def board_identifier
    self.person.board_id
  end
end
