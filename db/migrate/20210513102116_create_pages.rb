class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.string :name, null: false
      t.text :css

      t.timestamps
    end
  end
end
