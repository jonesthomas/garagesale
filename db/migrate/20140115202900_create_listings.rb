class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.integer :user_id
			t.string :specific_location
      t.string :zip_code
      t.decimal :price, :precision => 8, :scale => 2
      t.text :details
      t.boolean :active, default: false

      t.timestamps
    end
    add_index :listings, [:user_id, :created_at]
  end
end
