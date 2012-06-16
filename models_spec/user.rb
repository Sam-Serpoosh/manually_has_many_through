class User < ActiveRecord::Base

  attr_accessible :name, :email

  has_many :following_relationships, :class_name => "Relationship", :foreign_key => "follower_id"
  has_many :followers_relationships, :class_name => "Relationship", :foreign_key => "followed_id"

  def follow!(user)
    following_relationships << Relationship.new(:follower => self, :followed => user)
  end

  def unfollow!(user)
    relationship = following_relationships.find_by_followed_id(user.id)
    following_relationships.delete(relationship)
    user.followers_relationships.delete(relationship)
    relationship.destroy
  end

  def following
    following_relationships.map(&:followed)
  end

  def followers
    followers_relationships.map(&:follower)
  end

end
