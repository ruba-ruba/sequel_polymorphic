require File.dirname(__FILE__) + '/../spec_helper'

# Schema here for reference
# class Asset < Sequel::Model
#   set_schema { primary_key :id; varchar :name; integer :attachable_id; varchar :attachable_type }
#   is :polymorphic
#   belongs_to :attachable, :polymorphic => true
# end
# 
# class Post < Sequel::Model
#   set_schema { primary_key :id; varchar :name }
#   is :polymorphic
#   has_many :assets, :as => :attachable
# end
# 
# class Note < Sequel::Model
#   set_schema { primary_key :id; varchar :name; }
#   is :polymorphic
#   has_many :assets, :as => :attachable
# end

describe Sequel::Plugins::Polymorphic do
  before do
    Post.delete_all
    Asset.delete_all
  end

  it "should create an add_asset method which associates an Asset with a Post" do
    post = Post.create(:name => 'test post')
    asset = Asset.create(:name => "post's asset")
    post.add_asset(asset)
    asset.attachable_id == post.pk
    asset.attachable_type == post.class
  end
  
  it "should return the list of related objects" do
    post = Post.create(:name => 'test post')
    asset1 = Asset.create(:name => "post's first asset")
    asset2 = Asset.create(:name => "post's second asset")
    post.add_asset(asset1)
    post.add_asset(asset2)
    post.assets.should == [asset1,asset2]
  end
end
