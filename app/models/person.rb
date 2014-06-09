class Person < ActiveRecord::Base
  has_paper_trail :meta => { :board_id  => :board_id }
  belongs_to :team
  belongs_to :board
  validates :name, presence: { message: "Please specify a name"}
  validates_uniqueness_of :uid, scope: [:board_id], presence: { message: "Unique UID is required"}

  searchkick autocomplete: ['name']
end
