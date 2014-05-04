class Team < ActiveRecord::Base
  validates_uniqueness_of :name
end
