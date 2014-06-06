class Board < ActiveRecord::Base
  has_paper_trail
  belongs_to :user
  belongs_to :network
  has_many :initiatives
  has_many :teams
  has_many :roles
  has_many :people
  validates :network_id, presence: { message: "Is user logged in?"}
  validates :name, presence: { message: "Please specify a name"}
end
