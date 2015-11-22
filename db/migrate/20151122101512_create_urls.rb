class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url_text
      t.integer :clicks
      t.boolean :active

      t.timestamps null: false
    end
  end
end
