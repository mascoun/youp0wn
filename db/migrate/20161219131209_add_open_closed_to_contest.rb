class AddOpenClosedToContest < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :open, :boolean
  end
end
