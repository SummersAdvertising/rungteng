#encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :order_companytaxID, :order_email, :order_name, :order_phone, :order_fax, :receive_address, :receive_date, :receive_name, :receive_phone, :receive_time, :totalprice, :shippingfee, :note
  validates :order_name, :order_phone, :order_email, :receive_name, :receive_phone, :receive_address, :receive_date, :receive_time, :presence => { :message => "不能為空" }
  validates_numericality_of :totalprice, :greater_than => 0, :message => "不能為零"
  validates_format_of :order_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, :message => "不是正確的email"

  paginates_per 15
  
  has_many :orderitems, :dependent => :destroy
  has_many :products, :through => :orderitems
end
