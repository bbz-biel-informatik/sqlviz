class Page < ApplicationRecord
  has_many :visuals, dependent: :destroy
  has_many :memberships
  has_many :users, through: :memberships
end
