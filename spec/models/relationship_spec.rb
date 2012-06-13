require 'spec_helper'

describe Relationship do

  before do
    @relationship = Relationship.new
  end

  it "has follower method" do
    @relationship.should respond_to(:follower)
  end

  it "has followed method" do
    @relationship.should respond_to(:followed)
  end

end
