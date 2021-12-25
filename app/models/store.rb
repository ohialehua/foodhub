class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :endusers, through: :markers
end
