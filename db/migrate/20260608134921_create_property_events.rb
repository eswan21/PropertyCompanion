class CreatePropertyEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :property_events do |t|
      t.references :property, null: false, foreign_key: true
      t.string :event_type, null: false
      t.text :note
      t.references :created_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
