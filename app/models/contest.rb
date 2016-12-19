class Contest < ApplicationRecord
    has_and_belongs_to_many :challenges
    has_many :teams


   # has_attached_file :photo, styles: { medium: "1170x350" }, default_url: "/images/:style/missing.png"
   # validates_attachment :photo, presence: true
   # do_not_validate_attachment_file_type :photo


#    accepts_nested_attributes_for :challenges
   # attr_accessor :photo_file_name
end
