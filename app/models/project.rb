class Project < ActiveRecord::Base
  has_paper_trail
  validates :name, presence: { message: "Please specify a name"}
  belongs_to :initiative
  has_many :project_members, :dependent => :destroy
  has_many :members, :through => :project_members, :source => :person
end
