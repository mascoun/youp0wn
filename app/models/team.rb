class Team < ApplicationRecord
    before_create :create_join_digest

    serialize :challenges_ids

    has_and_belongs_to_many :users
    #has_many :challenges
    belongs_to :contest

  #  accepts_nested_attributes_for :users

  #  attr_accessor :contest_id
    #attr_accessor :challenges
 #  attr_accessor :join_digest



    def Team.new_token
    SecureRandom.urlsafe_base64
  end


def create_join_digest
    self.join_digest = Team.new_token
  end
end
