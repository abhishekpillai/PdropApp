class AddRpxToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rpx_identifier, :string

  end
end
