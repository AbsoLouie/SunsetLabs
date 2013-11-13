class User < ActiveRecord::Base
  validates :name, :email, :phone_number, :password_hash, presence: true
  validates :email, :phone_number, uniqueness: true
  validates :email, format: => { with: /\s{2,}[@]\s{2,}[.]\s{2,}/ }

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end