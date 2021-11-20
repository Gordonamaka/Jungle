class User < ActiveRecord::Base
  has_secure_password

  validates :password, presence: true, length: {minimum: 5}
  validates :password_confirmation, presence: true, length: {minimum: 5}
  validates :email, presence: true,  uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email_address, password)

    user = User.find_by_email(email_address.strip.downcase)

    if user && user.authenticate(password)
      return user
    else
      nil
    end

  end

end

# Password needs a minimum length, get rid of spaces within registration and login in the email
# Check for uppercases, it should still be logged in