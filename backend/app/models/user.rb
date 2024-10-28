class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_products, dependent: :destroy
  
  validates :gender, inclusion: { in: %w(male female other) }, allow_nil: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 100 }, allow_nil: true
  validates :prefecture, presence: true, allow_blank: true
  validates :city, presence: true, allow_blank: true
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
