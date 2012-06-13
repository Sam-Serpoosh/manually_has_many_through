require 'spec_helper'

describe User do

  before do
    @user = User.create!(name: "farzad", email: "fattahi@tednap.com")
    @other_user = User.create!(name: "sam", email: "ssjesus287@gmail.com")
  end

  it "sets name and email correctly" do
    user = User.new(name: "sam", email: "ssjesus287@gmail.com")
    user.name.should == "sam"
    user.email.should == "ssjesus287@gmail.com"
  end

  it "has following method" do
    @user.should respond_to(:following)
  end

  it "has followers method" do
    @user.should respond_to(:followers)
  end

  it "can follow another user" do
    @user.follow!(@other_user)
    @user.following_users.should include(@other_user)
  end

  it "doesn't contain non-followed user in the following_users collection" do
    @user.following_users.should_not include(@other_user)
  end

  it "contains follower in the followers collection" do
    @other_user.follow!(@user)
    @user.followers_users.should include(@other_user)
  end

  it "doesn't contain non-followers in the followers collection" do
    @user.followers_users.should_not include(@other_user)
  end

  it "unfollow another user" do
    @user.follow!(@other_user)
    @other_user.followers_users.should include(@user)
    @user.unfollow!(@other_user)
    @user.following_users.should_not include(@other_user)
    @other_user.followers_users.should_not include(@user)
  end

end
