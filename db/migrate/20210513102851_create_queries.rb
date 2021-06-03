class CreateQueries < ActiveRecord::Migration[6.1]
  def change
    create_table :queries do |t|
      t.references :visual, null: false, foreign_key: true
      t.string :query, null: false

      t.timestamps
    end
  end
end
