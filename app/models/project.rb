class Project < ActiveRecord::Base
  validates :name, presence: { message: "Please specify a name"}
  belongs_to :initiative
  has_many :project_members
end
