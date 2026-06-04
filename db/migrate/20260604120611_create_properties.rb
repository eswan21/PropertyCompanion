class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.references :search, null: false, foreign_key: true
      t.string :title
      t.string :location
      t.integer :price_per_month
      t.integer :personal_priority
      t.string :url
      t.string :address
      t.string :postcode
      t.string :council_tax_band
      t.string :epc_rating
      t.text :disadvantages
      t.text :notes
      t.boolean :open, default: true, null: false

      t.timestamps
    end
  end
end
