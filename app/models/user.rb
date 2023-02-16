class User < ApplicationRecord
  has_many :reviews, dependent: :delete_all
  has_many :carts, dependent: :delete_all

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :credit_card, length: { is: 16 }
  validates :phone_number, length: { is: 10 }
  
end
