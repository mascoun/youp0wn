json.extract! team, :id, :name, :score, :challenges_ids, :created_at, :updated_at
json.url contest_teams_url(team, format: :json)