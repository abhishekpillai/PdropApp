class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.string :title
      t.string :link
      t.text :text
      t.integer :goals
      t.boolean :flag

      t.timestamps
    end
  end
end
