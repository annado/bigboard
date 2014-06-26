class AddGroupIdForYammerPostToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :group_id_for_yammer_post, :integer
  end
end
