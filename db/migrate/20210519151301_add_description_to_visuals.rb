class AddDescriptionToVisuals < ActiveRecord::Migration[6.1]
  def change
    add_column :visuals, :description, :text
  end
end
