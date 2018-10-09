class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :url
      t.string :url_with_protocol
      t.string :type
      t.references :track, foreign_key: true
      t.references :playlist, foreign_key: true
      t.references :album, foreign_key: true
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
