class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :purchases, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, email: {mode: :rfc}

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  # Custom validations
  validate :credit_card_validation
  validate :phone_number_validation

  def numeric_string_check(string)
    string.scan(/^\d+$/).present?
  end

  def credit_card_validation
    unless self.credit_card.nil? or self.credit_card.empty?
      unless self.credit_card.length == 16
        errors.add(:credit_card, 'must be 16 digits long')
      end
      unless numeric_string_check(self.credit_card)
        errors.add(:credit_card, 'must contain only numbers')
      end
    end
  end

  def phone_number_validation
    unless self.phone_number.nil? or self.phone_number.empty?
      unless self.phone_number.length == 10
        errors.add(:phone_number, 'must be 10 digits long')
      end

      unless numeric_string_check(self.phone_number)
        errors.add(:phone_number, 'must contain only numbers')
      end
    end
  end




  # validates :credit_card, length: { is: 16 }
  # validates :phone_number, length: { is: 10 }
  
end
