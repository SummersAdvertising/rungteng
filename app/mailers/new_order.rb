#encoding: utf-8
class NewOrder < ActionMailer::Base
  default from: "customerservice@longtermyeast.com"
  def send_order(order)
  	@order = order

    mail(:to => [@order.order_email],
    	#, "carolkao@longtermyeast.com", "customerservice@longtermyeast.com"
  	#mail(:to => ["yuzhe@summers.com.tw"],
  	     :subject => "榮騰農產：來自#{@order.order_name}的訂單")  	
  end
end
