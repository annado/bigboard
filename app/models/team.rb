class Team < ActiveRecord::Base
  belongs_to :board
  validates_uniqueness_of :name, scope: [:board_id], presence: { message: "Unique team name required"}
end
