class AddMemberIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :member_id, :string
  end
end
