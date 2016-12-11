module UsersHelper
    def has_team_in_contest(user,contest)
        b = false
        user.teams.each do |team|
            if team.contest.id == contest.id
                b = true
            end
        end
        return b
    end
    def team_user(user,contest)
        user.teams.find_by(contest: contest)
    end
end
