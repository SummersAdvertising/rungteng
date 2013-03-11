class OrdersController < ApplicationController
  def index
    @items = Product.where("producttype = ?", "item").order('ordernum ASC, updated_at DESC, created_at DESC')
    @boxs = Product.where("producttype = ?", "box").order('ordernum ASC, updated_at DESC, created_at DESC')
    @order = Order.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  def order_check
    @order = Order.new
    if(params[:orderitems])
      @orderitems = ActiveSupport::JSON.decode("["+params[:orderitems]+"]")
    else
      respond_to do |format|
        format.html { redirect_to action: "index" }
      end
    end
  end

  def order_finish
  end

  def create
    products = Product.order('addDate DESC, updated_at DESC, created_at DESC').all
    @order = Order.new(params[:order])
    @orderitems = ActiveSupport::JSON.decode(params[:orderitems])

    respond_to do |format|
      if @order.save
        @orderitems.each do|orderitem|
          @orderitem = @order.orderitems.new()
          @orderitem.product_id = orderitem['id']
          @orderitem.amount = orderitem['amount']

          @orderitem.save

        end
        format.html { redirect_to action: "order_finish" }
        format.json { render json: @order, status: :created, location: @order }
        format.js {}       

      else
        format.html { render action: "index" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

end
