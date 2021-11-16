class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 4}

  def self.authenticate_with_credentials(email, password)
    password_lower_case = email.downcase.strip
    
    user = User.find_by_email(password_lower_case)

    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end