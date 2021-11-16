require 'rails_helper'

RSpec.describe User, type: :model do
  it "should create a new user if all required fields are met" do
    user = User.new(first_name: "jon", last_name: "jones", email: "jon.jones@gmail.com", password: "test", password_confirmation: "test")
    expect(user.valid?).to eq(true)
  end

  it "should not create a new user if the first_name field is blank" do
    user = User.new(first_name: nil, last_name: "jones", email: "jon.jones@gmail.com", password: "test", password_confirmation: "test")
    expect(user.valid?).to eq(false)
  end

  it "should not create a new user if the last_name field is blank" do
    user = User.new(first_name: "jon", last_name: nil, email: "jon.jones@gmail.com", password: "test", password_confirmation: "test")
    expect(user.valid?).to eq(false)
  end

  it "should not create a new user if the email field is blank" do
    user = User.new(first_name: "jon", last_name: "jones", email: nil, password: "test", password_confirmation: "test")
    expect(user.valid?).to eq(false)
  end

  it "should not create a new user if the password and password_confirmation fields do not match" do
    user = User.new(first_name: "jon", last_name: "jones", email: "jon.jones@gmail.com", password: "test", password_confirmation: "tests")
    expect(user.valid?).to eq(false)
  end

  it "should not create a new user if the email field is not unique (IE. a record with this email already exists in the db) and is not case sensitive" do
    user1 = User.create(first_name: "jon", last_name: "jones", email: "jon.jones@gmail.com", password: "test", password_confirmation: "test")
    user2 = User.create(first_name: "jon", last_name: "jones", email: "JON.JONES@gmail.com", password: "test", password_confirmation: "test")
    expect(user2.errors.full_messages).to include("Email has already been taken")
  end

  it "should not create a new user if the email field is < 4 characters long" do
    user = User.new(first_name: "jon", last_name: "jones", email: "jon.jones@gmail.com", password: "tst", password_confirmation: "tst")
    expect(user.valid?).to eq(false)
  end
  
end

describe 'authenticate_with_credentials' do
  it 'should login the user given correct credentials' do
    @user = User.new(first_name: "jon", last_name: "jones", email: "jon.jones@gmail.com", password: "test", password_confirmation: "test")
    @user.save
    expect(User.authenticate_with_credentials("jon.jones@gmail.com", "test")).to be_present
  end

  it 'should not login the user given incorrect credentials' do
    @user = User.new(first_name: "jon", last_name: "jones", email: "jon.jones@gmail.com", password: "testtest", password_confirmation: "testtest")
    @user.save
    expect(User.authenticate_with_credentials("jon.jones@gmail.com", "test")).not_to be_present
  end

  it 'should login the user even if the email has extra spaces' do
    @user = User.new(first_name: "jon", last_name: "jones", email: "jon.jones@gmail.com", password: "testtest", password_confirmation: "testtest")
    @user.save
    expect(User.authenticate_with_credentials("   jon.jones@gmail.com   ", "testtest")).to be_present
  end

  it 'should login the user even if the email was typed in a different case' do
    @user = User.new(first_name: "jon", last_name: "jones", email: "jon.jones@gmail.com", password: "testtest", password_confirmation: "testtest")
    @user.save
    expect(User.authenticate_with_credentials("JON.JONES@gmail.com", "testtest")).to be_present
  end

end