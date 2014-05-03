class Project < ActiveRecord::Base
  validates :name, presence: { message: "Please specify a name"}
end
