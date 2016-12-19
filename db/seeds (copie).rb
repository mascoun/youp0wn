require 'csv'

CSV.foreach("#{Rails.root}/db/csv/users.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  User.create(row.to_hash)
end
