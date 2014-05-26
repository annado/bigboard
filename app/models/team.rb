class Team < ActiveRecord::Base
  validates_uniqueness_of :name
  belongs_to :board
end
