class CreateEmbeds < ActiveRecord::Migration
  def self.up
    create_table :embeds do |t|
      t.string :embed_owner_type
      t.integer :embed_owner_id
      t.string :url
      t.string :title
      t.text :html
      t.timestamps
    end
  end

  def self.down
    drop_table :embeds
  end
end
