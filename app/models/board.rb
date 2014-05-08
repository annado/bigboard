class Board < ActiveRecord::Base
  belongs_to :user
  belongs_to :network
  validates :network_id, presence: { message: "Is user logged in?"}
  validates :name, presence: { message: "Please specify a name"}
end
