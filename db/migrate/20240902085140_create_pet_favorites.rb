class CreatePetFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :pet_favorites do |t|
      t.references :user, foreign_key: true
      t.references :pet, foreign_key: true
      t.timestamps
    end
  end
end
