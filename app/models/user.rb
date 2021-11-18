class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence:true
  validates :email, presence:true
  validates :password, presence:true

  def self.authenticate_with_credentials(email, password)

    user = User.find_by_email(email)
    user && user.authenticate(password)

  end

end

# Password needs a minimum length, get rid of spaces within registration and login in the email
#check for uppercases, it should still be logged in
# If there's time use a prompt for wrong emails