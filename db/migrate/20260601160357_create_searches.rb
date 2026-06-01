class CreateSearches < ActiveRecord::Migration[8.1]
  def change
    create_table :searches do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
