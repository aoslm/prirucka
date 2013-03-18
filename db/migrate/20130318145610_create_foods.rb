class CreateFoods < ActiveRecord::Migration
  def change
		drop_table :foods
    create_table :foods do |t|
      t.string :name
      t.string :englishName
      t.string :type
      t.decimal :water
      t.decimal :fat
      t.decimal :proteins
      t.decimal :energy

      t.timestamps
    end
  end
end
