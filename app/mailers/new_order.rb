#encoding: utf-8
class NewOrder < ActionMailer::Base
  default from: "service@longtermyeast.com"
  def send_order(order)
  	@order = order

  	mail(:to => [@order.order_email, "carolkao@longtermyeast.com", "service@longtermyeast.com", "kobanae@summers.com.tw"],
  	     :subject => "[榮騰網站]來自#{@order.order_name}的訂單")
  	
  end
end
