class CreateAlbumTags < ActiveRecord::Migration[6.1]
  def change
    create_table :album_tags do |t|
      t.references :album, forign_key: true
      t.references :tag, forign_key: true
      t.timestamps
    end
  end
end
