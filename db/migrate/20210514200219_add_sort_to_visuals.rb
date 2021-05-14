class AddSortToVisuals < ActiveRecord::Migration[6.1]
  def change
    add_column :visuals, :sort, :integer
  end
end
