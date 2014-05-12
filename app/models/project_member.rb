class ProjectMember < ActiveRecord::Base
  validates :project_id, presence: { message: "Requires project"}
  belongs_to :project
end
