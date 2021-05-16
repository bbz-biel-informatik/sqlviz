class Page < ApplicationRecord
  has_many :visuals
  has_many :memberships
  has_many :users, through: :memberships
end
