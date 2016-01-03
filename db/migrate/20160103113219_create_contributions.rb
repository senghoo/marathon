class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :member_id
      t.date :date
      t.integer :count

      t.timestamps null: false
    end
  end
end
