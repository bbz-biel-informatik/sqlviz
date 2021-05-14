class CreateVisuals < ActiveRecord::Migration[6.1]
  def change
    create_table :visuals do |t|
      t.references :page, null: false, foreign_key: true
      t.string :name, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end