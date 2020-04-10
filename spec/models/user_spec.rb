require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "is valid with password and confirmation matching" do
    user = User.new(first_name: 'david', last_name: 'Smith', email: 'jd@a.com')
    user.save                                                     
    user.password = 'mUc3m00RsqyRe'
    user.save                                                      
    user.password_confirmation = 'mUc3m00RsqyRe'
    user.save
    expect(user).to be_valid
    end

    it "password and confirmation do not match" do
        user = User.new(first_name: 'david', last_name: 'Smith', email: 'jd@a.com')
        user.save                                                     
        user.password = 'mUc3m00RsqyRe'
        user.save                                                      
        user.password_confirmation = 'opc3m00Rsqyqw'
        user.save
        expect(user.password).not_to eql(user.password_confirmation)
     
    end

    it "cannot create user without password fields" do
      user = User.new(first_name: 'david', last_name: 'Smith', email: 'jd@a.com')
      user.save                                                     
      user.password = nil
      user.save                                                      
      user.password_confirmation = nil
      user.save
      expect(user).not_to be_valid
    end
    it "cannot create user if email is not unique" do
      user = User.new(first_name: 'david', last_name: 'Smith', email: 'jd@a.com')
      user.save                                                     
      user.password = 'qwe'
      user.save                                                      
      user.password_confirmation = 'qwe'
      user.save
      user2 = User.new(first_name: 'ed', last_name: 'ban', email: 'jd@a.com')
      expect(user2).not_to be_valid
  end
  it "cannot create user if email is not unique" do
    user = User.new(first_name: nil, last_name: nil, email: nil)
    expect(user).not_to be_valid
  end

  it "password must have minimum 6 character length" do
    user = User.new(first_name: 'ed', last_name: 'ban', email: 'jd@a.com', password: 'qwew')
    expect(user).not_to be_valid
  end  
end

  describe '.authenticate_with_credentials' do
    it "should login user with correct credentials" do
     user = User.new(first_name: 'ed', last_name: 'win', email: 'ewin@q.com', password: 'password', password_confirmation: 'password')
      user.save
      expect(User.authenticate_with_credentials('ewin@q.com', 'password')).to be_truthy
    end

    it "should  not login user with incorrect credentials" do
      user = User.new(first_name: 'ed', last_name: 'win', email: 'ewin@q.com', password: 'password', password_confirmation: 'password')
      user.save
      expect(User.authenticate_with_credentials('a@bc.com', 'qawerty')).to be_falsy
    end  

    it "should login user when email in databse is mixed case and login email is lowercase" do
      user = User.new(first_name: 'ed', last_name: 'win', email: ' eWIn@q.com  ', password: 'password', password_confirmation: 'password')
      user.save
      expect(User.authenticate_with_credentials('ewin@q.com', 'password')).to be_truthy
    end

    it "should login user when database email and login email are mixed case" do
      user = User.new(first_name: 'ed', last_name: 'win', email: ' eWIn@q.com  ', password: 'password', password_confirmation: 'password')
      user.save
      expect(User.authenticate_with_credentials('ewin@q.com', 'password')).to be_truthy
    end

  end
end
