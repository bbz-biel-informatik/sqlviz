class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
