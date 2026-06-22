class CreateSearchInvitations < ActiveRecord::Migration[8.1]
  def change
    create_table :search_invitations do |t|
      t.references :search, null: false, foreign_key: true
      t.references :invited_by, null: false, foreign_key: { to_table: :users }
      t.string :email
      t.string :token
      t.datetime :accepted_at
      t.datetime :expires_at

      t.timestamps
    end

    add_index :search_invitations, :token, unique: true
    add_index :search_invitations, [ :search_id, :email ], unique: true
  end
end
