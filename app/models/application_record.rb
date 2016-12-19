class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names ## Header values of CSV
      all.each do |emp|
        csv << emp.attributes.values_at(*column_names) ##Row values of CSV
      end
    end
  end
end
