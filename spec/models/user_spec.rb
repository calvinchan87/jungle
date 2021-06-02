require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    it 'returns valid if all fields have valid values' do
      @user = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      expect(@user).to be_valid
    end

    it 'does not return valid if first name == nil' do
      @user = User.create first_name: nil, last_name: 'Su', email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      expect(@user).to_not be_valid
    end

    it 'does not return valid if last name == nil' do
      @user = User.create first_name: 'Lisa', last_name: nil, email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      expect(@user).to_not be_valid
    end

    it 'does not return valid if email == nil' do
      @user = User.create first_name: 'Lisa', last_name: 'Su', email: nil, password: 'rx6900xt', password_confirmation: 'rx6900xt'
      expect(@user).to_not be_valid
    end

    it 'does not return valid if email is not unique' do
      @userOne = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      @userTwo = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      expect(@userTwo).to_not be_valid
    end

    it 'does not return valid if email is not unique && even if case is different' do
      @userOne = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      @userTwo = User.create first_name: 'Lisa', last_name: 'Su', email: 'LSU@AMD.COM', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      expect(@userTwo).to_not be_valid
    end

    it 'does not return valid if password == nil' do
      @user = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: nil, password_confirmation: 'rx6900xt'
      expect(@user).to_not be_valid
    end

    it 'does not return valid if password and password confirmation do not match' do
      @user = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6800xt', password_confirmation: 'rx6900xt'
      expect(@user).to_not be_valid
    end

    it 'does not return valid if password is at least 8 characters long' do
      @user = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6800', password_confirmation: 'rx6800'
      expect(@user).to_not be_valid
    end
  
  end

  describe '.authenticate_with_credentials' do

    it 'should authenticate user if email and password are valid' do
      @user = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      authenticated_user = User.authenticate_with_credentials('lsu@amd.com', 'rx6900xt')
      expect(authenticated_user).to eq(@user)
    end

    it 'should authenticate user even if email has spaces before or after it' do
      @user = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      authenticated_user = User.authenticate_with_credentials(' lsu@amd.com ', 'rx6900xt')
      expect(authenticated_user).to eq(@user)
    end

    it 'should authenticate user even if email case is different' do
      @user = User.create first_name: 'Lisa', last_name: 'Su', email: 'lsu@amd.com', password: 'rx6900xt', password_confirmation: 'rx6900xt'
      authenticated_user = User.authenticate_with_credentials('LSU@AMD.COM', 'rx6900xt')
      expect(authenticated_user).to eq(@user)
    end

  end

end
