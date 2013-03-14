class NewOrder < ActionMailer::Base
  default from: "mail@rungteng.com"
  def send_order(order)
  	@order = order

  	mail(:to => [@order.order_email],
  	     :subject => "#{@order.order_name}, your order")
  	
  end
end
