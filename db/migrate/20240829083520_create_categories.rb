class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name,null: false
      t.text :introduction,null: false
      t.integer :difficulty,null:false, default: 0
      t.timestamps
    end
  end
end
