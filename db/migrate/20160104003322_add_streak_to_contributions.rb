class AddStreakToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :streak, :integer
  end
end
