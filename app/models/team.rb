class Team < ActiveRecord::Base
  validates_uniqueness_of :name, scope: [:board_id]
  belongs_to :board
end
