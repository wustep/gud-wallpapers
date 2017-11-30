class AddUserRankToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_rank, :integer
  end
end
