class AddFormToVisuals < ActiveRecord::Migration[6.1]
  def change
    add_column :visuals, :form, :text
  end
end
