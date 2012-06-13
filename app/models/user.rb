class User < ActiveRecord::Base

  attr_accessible :name, :email

  has_many :following, :class_name => "Relationship", :foreign_key => "follower_id"
  has_many :followers, :class_name => "Relationship", :foreign_key => "followed_id"

  def follow!(user)
    self.following << Relationship.new(:follower => self, :followed => user)
  end

  def unfollow!(user)
    relationship = Relationship.find_by_followed_id(user.id)
    following.delete(relationship)
    user.followers.delete(relationship)
    relationship.destroy
  end

  def following_users
    following.map(&:followed)
  end

  def followers_users
    followers.map(&:follower)
  end

end
