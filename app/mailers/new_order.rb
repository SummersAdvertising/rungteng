class NewOrder < ActionMailer::Base
  default from: "mail@rungteng.com"
  def send_order(order)
  	@order = order

  	mail(:to => [@order.order_email],
  	     :subject => "[榮騰網站]來自#{@order.order_name}的訂單")
  	
  end
end
