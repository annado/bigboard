class Network < ActiveRecord::Base
  validates :name, presence: { message: "Please specify a name"}
  validates :nid, presence: { message: "Requires network id"}
end
