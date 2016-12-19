File.open("./db/csv/users.csv","w+") do |f|
f.write(User.all.to_csv)
end
File.open("./db/csv/contests.csv","wb") do |f|
f.write(Contest.all.to_csv)
end
File.open("./db/csv/challenges.csv","w+") do |f|
f.write(Challenge.all.to_csv)
end
File.open("./db/csv/categories.csv","w+") do |f|
f.write(Category.all.to_csv)
end
File.open("./db/csv/teams.csv","w+") do |f|
f.write(Team.all.to_csv)
end
