class RemoveType < ActiveRecord::Migration
  def up
					remove_column :foods, :type
  end

  def down
					add_column :foods, :typ, :string
  end
end
