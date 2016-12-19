class AddTeamUsersNumberToContest < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :team_user_number, :integer
  end
end
