class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :description
      t.string :flag
      t.string :attachement
      t.integer :score
      t.references :contest, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
        #add_index :challenges, [:contest_id]
        #add_index :challenges, [:category_id]
  end
end
