class User < ActiveRecord::Base
  include BCrypt
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.login(email, password)
    user = User.find_by_email(email)
    if user.nil?
      return nil 
    elsif user.password == password
      return user
    else
      return nil
    end
  end
end
