class AddMoreDetailsToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :fat, :decimal
    add_column :foods, :proteins, :decimal
    add_column :foods, :sugar, :decimal
    add_column :foods, :cholesterol, :decimal
  end
end
