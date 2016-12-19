class Challenge < ApplicationRecord
    has_and_belongs_to_many :contest
    belongs_to :category
    accepts_nested_attributes_for :contest
    accepts_nested_attributes_for :category
    attr_accessor :contest_id
    attr_accessor :category_id
end
