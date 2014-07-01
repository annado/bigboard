require 'yammer'

class Board < ActiveRecord::Base
  has_paper_trail :meta => { :board_id  => :id }

  belongs_to :user
  belongs_to :network
  has_many :initiatives, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :roles, :dependent => :destroy
  has_many :people, :dependent => :destroy

  validates :network_id, presence: { message: "Is user logged in?"}
  validates :name, presence: { message: "Please specify a name"}

  def ongoing_initiatives
      self.initiatives.where(completed: false).order(:created_at)
  end

  def people_ending_soon
    @people_ending_soon = []
    self.people.each do |p|
      if (p.project_members.count == 1 && p.project_members[0].end_date)
        if p.freeing_up_soon? && p.team.single_project?
          @people_ending_soon << [p.name, p.project_members[0].end_date]
        end
      end
    end
    @people_ending_soon
  end

end
