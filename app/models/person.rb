
class Person < ActiveRecord::Base
  belongs_to :team
  belongs_to :network
  validates :name, presence: { message: "Please specify a name"}
  validates_uniqueness_of :uid, presence: { message: "Unique UID is required"}

  searchkick autocomplete: ['name']

end
