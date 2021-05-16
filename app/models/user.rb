class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable, :recoverable,
        :rememberable, :validatable

  has_many :memberships
  has_many :pages, through: :memberships
  has_many :visuals, through: :pages
end
