class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :score, default: 0
      t.references :contest
      t.integer :fault, default: 0
      t.text :challenges_ids, array: true, default: "--- []\n"
      t.string :join_digest

      t.timestamps
    end
  end
end
