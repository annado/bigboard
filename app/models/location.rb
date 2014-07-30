class Location < ActiveRecord::Base
  validates :name, presence: { message: "Please specify a location name"}
  validates_uniqueness_of :name, scope: [:board_id], presence: { message: "Please specify a unique location name"}

  belongs_to :board

  has_many :people, dependent: :nullify
  has_many :projects, dependent: :nullify
end
