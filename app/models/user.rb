class User < ApplicationRecord
  has_many :experiences, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :bookings_as_host, through: :experiences, source: :bookings
  has_one_attached :photo

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
