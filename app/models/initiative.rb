class Initiative < ActiveRecord::Base
  belongs_to :manager, class_name: "Person"
  belongs_to :analyst, class_name: "Person"
  belongs_to :owner, class_name: "Person"
  has_many :projects
end
