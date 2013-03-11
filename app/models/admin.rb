class Admin < ActiveRecord::Base
  attr_accessible :name, :password, :username
  validates :password, :username, :presence => true
  validates :username, :uniqueness => true
end
