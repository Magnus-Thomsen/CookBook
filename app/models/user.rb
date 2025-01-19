class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes

  validates :name, presence: true # Optional, only if you want to enforce that users must provide a name.

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [400, 400]
  end

  has_many :likes, dependent: :destroy
end
