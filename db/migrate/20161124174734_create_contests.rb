class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.datetime :begins, null: false
      t.datetime :ends, null: false
      t.binary :photo , :limit => 10.megabyte

      t.timestamps
    end
  end
end
