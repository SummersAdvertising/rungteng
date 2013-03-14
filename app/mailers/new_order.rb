class NewOrder < ActionMailer::Base
  default from: "from@example.com"
  def send_order(order)
  	@order = order

  	mail(:to => [@order.email, "kobanae@gmail.com"],
  	     :subject => "#{@order.customername}, your order")
  	
  end
end
