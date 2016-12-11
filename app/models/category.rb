class Category < ApplicationRecord
	has_many :challenges
	#accepts_nested_attributes_for :challenges
	#attr_accessor :challenges
end
