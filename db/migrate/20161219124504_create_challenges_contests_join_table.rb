class CreateChallengesContestsJoinTable < ActiveRecord::Migration[5.0]

    def self.up
    create_table :challenges_contests, :id => false do |t|
      t.integer :challenge_id
      t.integer :contest_id
    end

    add_index :challenges_contests, [:challenge_id, :contest_id]
  end

  def self.down
    drop_table :challenges_contests
  end
end
