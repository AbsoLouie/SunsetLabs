class User < ActiveRecord::Base
  validates :name, :email, :phone_number, :password_hash, presence: true
  validates :email, :phone_number, uniqueness: true
  validates :email, format: => { with: /\s{2,}[@]\s{2,}[.]\s{2,}/ }
end