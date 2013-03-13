class Order < ActiveRecord::Base
  attr_accessible :order_companytaxID, :order_email, :order_name, :order_phone, :order_fax, :receive_address, :receive_date, :receive_name, :receive_phone, :receive_time, :totalprice, :shippingfee, :note
  #validates :order_companytaxID, :order_email, :order_name, :order_phone, :receive_address, :receive_date, :receive_name, :receive_phone, :receive_time, :totalprice, :presence => true

  paginates_per 15
  
  has_many :orderitems, :dependent => :destroy
  has_many :products, :through => :orderitems
end
