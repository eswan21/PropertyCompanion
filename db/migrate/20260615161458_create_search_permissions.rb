class CreateSearchPermissions < ActiveRecord::Migration[8.1]
  def change
    create_table :search_permissions do |t|
      t.references :search, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :search_permissions, [ :search_id, :user_id ], unique: true
  end
end
