class Board < ActiveRecord::Base
  has_paper_trail :meta => { :board_id  => :id }

  belongs_to :user
  belongs_to :network
  has_many :initiatives, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :roles, :dependent => :destroy
  has_many :people, :dependent => :destroy

  validates :network_id, presence: { message: "Is user logged in?"}
  validates :name, presence: { message: "Please specify a name"}
end
