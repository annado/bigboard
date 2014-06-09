class Team < ActiveRecord::Base
  has_paper_trail :meta => { :board_id  => :board_id }
  belongs_to :board
  validates_uniqueness_of :name, scope: [:board_id], presence: { message: "Unique team name required"}
end
