class AddKlassToVisuals < ActiveRecord::Migration[6.1]
  def change
    add_column :visuals, :klass, :string
  end
end
