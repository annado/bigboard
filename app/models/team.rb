class Team < ActiveRecord::Base
  validates_uniqueness_of :name
  belongs_to :board
  belongs_to :network
end
