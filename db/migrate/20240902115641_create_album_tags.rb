class CreateAlbumTags < ActiveRecord::Migration[6.1]
  def change
    create_table :album_tags do |t|
      t.timestamps
    end
  end
end
