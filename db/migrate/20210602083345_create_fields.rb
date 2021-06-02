class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.string :name
      t.string :kind
      t.references :visual, null: false, foreign_key: true

      t.timestamps
    end
  end
end
