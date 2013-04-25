#encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :order_companytaxID, :order_email, :order_name, :order_phone, :order_fax, :receive_address, :receive_date, :receive_name, :receive_phone, :receive_time, :totalprice, :shippingfee, :note
  validates :order_companytaxID, :order_email, :order_name, :order_phone, :receive_address, :receive_date, :receive_name, :receive_phone, :receive_time, :totalprice, :presence => { :message => "請將表單填寫完整" }
  validates_numericality_of :totalprice, :greater_than => 0, :message => "訂單金額不能為零"

  paginates_per 15
  
  has_many :orderitems, :dependent => :destroy
  has_many :products, :through => :orderitems
end
