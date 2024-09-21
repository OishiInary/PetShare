class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name,null: false
      t.integer :gender,null: false
      t.integer :age,null: false
      t.boolean :need_help,null: false, default: "false"
      t.timestamps
    end
  end
end
