class AddDetailsToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :typ, :string
  end
end
