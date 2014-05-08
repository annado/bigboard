class Project < ActiveRecord::Base
  validates :name, presence: { message: "Please specify a name"}
  belongs_to :initiative
  belongs_to :board
end
