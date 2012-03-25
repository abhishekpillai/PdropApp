class AddGoalsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :goals, :integer

  end
end
