require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "should save when all required fields are filled" do 
      @user = User.new({password:'Wario', password_confirmation: 'Wario', email: 'Wario@gmail.com', first_name: "Catty", last_name: "Savage" })

      @user.save 
      expect(@user).to be_present
    end 

    it "returns 'First name can't be blank' if we try to create a User with a nil value in the first name field"  do 
      @user = User.new({password:'Wario', password_confirmation: 'Wario', email: 'Wario@gmail.com', first_name: nil, last_name: "Savage" })

      @user.valid?

      expect(@user.errors.full_messages).to include("First name can't be blank")

    end 

    it "should display Last name can't be blank" do 
      @user = User.new({password:'Wario', password_confirmation: 'Wario', email: 'Wario@gmail.com', first_name: "Catty", last_name: nil })

      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end 

    it "should display email can't be blank" do 
      @user = User.new({password:'Wario', password_confirmation: 'Wario', email: nil, first_name: "Catty", last_name: "Savage" })

      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end 

    it "should display password can't be blank" do 
      @user = User.new({password:nil, password_confirmation: 'Wario', email: 'Wario@gmail.com', first_name: "Catty", last_name: "Savage" })

      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end 

    it "should display password can't be less than five characters" do 
      @user = User.new({password: "sup", password_confirmation: "sup", email: 'Wario@gmail.com', first_name: "Catty", last_name: "Savage" })

      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end 

    it "should display password confirmation can't be less than five characters" do 
      @user = User.new({password: "sup", password_confirmation: "sup", email: 'Wario@gmail.com', first_name: "Catty", last_name: "Savage" })

      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end 

    it "should display password does not match the password confirmation" do 
      @user = User.new({password: "Wario", password_confirmation: "sup", email: 'Wario@gmail.com', first_name: "Catty", last_name: "Savage" })

      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end 


  describe '.authenticate_with_credentials' do

      it "returns an instance of the user model if an existing user tries to login with the correct email and password" do
        @user = User.new({password: 'wario', password_confirmation: 'wario', email: 'wario@gmail.com', first_name: "Catty", last_name: "Savage" })

        @user.save

        expect(User.authenticate_with_credentials('wario@gmail.com', 'wario' )).to eq(@user)
      end


      it "returns nil if an existing user tries to login with the correct email and incorrect password" do
        @user = User.new({password: 'Wario', password_confirmation: 'Wario', email: 'Wario@gmail.com', first_name: "Catty", last_name: "Savage" })

        @user.save

        expect(User.authenticate_with_credentials('Wario@gmail.com', 'sup' )).to be nil
      end

      it "returns nil if user attempts to login with an email that is not in the database " do
        @user = User.new({password: 'Wario', password_confirmation: 'Wario', email: 'Wario@gmail.com', first_name: "Catty", last_name: "Savage" })

        @user.save

        expect(User.authenticate_with_credentials('grimsby@gmail.com', 'Wario' )).to be nil
      end

      it "returns an instance of the user model if an existing user tries to login with the correct email(with inconsistences in the case of the characters) and password"do
      @user = User.new({password: 'princess', password_confirmation: 'princess', email: 'princess@gmail.com', first_name: "Luigi", last_name: "Daisy" })

      @user.save

      expect(User.authenticate_with_credentials('PriNcess@gmail.com','princess')).to eq(@user)
      end

    

      it "returns an instance of the user model if an existing user tries to login with the correct email(with some extra whitespace characters added to the start of the input) and correct password" do
      @user = User.new({password: 'princess', password_confirmation: 'princess', email: 'princess@gmail.com', first_name: "Luigi", last_name: "Daisy" })

      @user.save

      expect(User.authenticate_with_credentials('    princess@gmail.com', 'princess')).to eq(@user)
    end
  end
end
