class AddSvgToMembers < ActiveRecord::Migration
  def change
    add_column :members, :svg, :text, limit: 1073741823
  end
end
