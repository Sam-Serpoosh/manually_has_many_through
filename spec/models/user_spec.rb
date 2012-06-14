require 'spec_helper'

describe User do

  before do
    @user = User.create!(name: "sam", email: "sam@gmail.com")
    @other_user = User.create!(name: "john", email: "john@gmail.com")
  end

  it "has following_relationships method" do
    @user.should respond_to(:following_relationships)
  end

  it "has followers_relationships method" do
    @user.should respond_to(:followers_relationships)
  end

  it "can follow another user" do
    @user.follow!(@other_user)
    @user.following.should include(@other_user)
  end

  it "doesn't contain non-followed user in the following_users collection" do
    @user.following.should_not include(@other_user)
  end

  it "contains follower in the followers_users collection" do
    @other_user.follow!(@user)
    @user.followers.should include(@other_user)
  end

  it "doesn't contain non-followers in the followers_users collection" do
    @user.followers.should_not include(@other_user)
  end

  it "unfollow another user" do
    @user.follow!(@other_user)
    @user.unfollow!(@other_user)
    @user.following.should_not include(@other_user)
    @other_user.followers.should_not include(@user)
  end

end
