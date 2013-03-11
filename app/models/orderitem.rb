class Orderitem < ActiveRecord::Base
  attr_accessible :amount, :order_id, :product_id
  
  belongs_to :order
  belongs_to :product
end
