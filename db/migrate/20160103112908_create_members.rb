class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.text :name
      t.text :home
      t.integer :github_id

      t.timestamps null: false
    end
  end
end
