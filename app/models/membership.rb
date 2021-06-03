class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :page

  attr_reader :email
end
