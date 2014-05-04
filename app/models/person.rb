class Person < ActiveRecord::Base
  belongs_to :team
  validates :name, presence: { message: "Please specify a name"}
  validates_uniqueness_of :uid, presence: { message: "Unique UID is required"}
end
