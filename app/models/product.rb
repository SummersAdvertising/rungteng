class Product < ActiveRecord::Base
  attr_accessible :name, :price, :saleprice, :weight, :image, :addDate, :ordernum, :producttype, :description
  has_many :orderitems
  has_many :orders, :through => :orderitems

  mount_uploader :image, ImageUploader
end
