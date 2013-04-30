class OrdersController < ApplicationController
  layout false
  before_filter :count, :except => [:calculate]
  
  def count
    @count = counter()
  end
  
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

  def calculate
    @orderitems = params[:orderitems]
    if(@orderitems!="null")
      @orderinfo = Array.new
      @orderHasBox = false
      @ordersum = 0

      JSON.parse(@orderitems).each do |item|
        @item = Product.find(item["id"])
        @sum = @item.price * Integer(item["amount"])

        if(@item.producttype == "box")
          @orderHasBox = true
        end

        @ordersum = @ordersum + @sum

        @orderinfo.push({
          :itemid => @item.id,
          :name => @item.name,
          :weight => @item.weight,
          :ordernum => @item.ordernum,
          :amount => item["amount"],
          :sum => @sum
          })
      end
      @shippingfee = ((@ordersum  > 2000) || @orderHasBox)? 0:200
      @order = { iteminfo: @orderinfo.to_json,
        shippingfee: @shippingfee,
        ordernum: @ordersum
        }.to_json

      return render :text => @order
    else
      return render :text => "no items"
    end
    
  end

  def order_finish
  end

  def create
    @order = Order.new(params[:order])
    @orderitems = ActiveSupport::JSON.decode(params[:orderitems])

    respond_to do |format|
      if(@order.save)
        if(!@orderitems.blank?)
          @orderitems.each do|orderitem|
            @orderitem = @order.orderitems.new()
            @orderitem.product_id = orderitem['id']
            @orderitem.amount = orderitem['amount']

            @orderitem.save

          end

          # send a order Email after save
          NewOrder.send_order(@order).deliver
          format.html { redirect_to action: "order_finish" }
          format.json { render json: @order, status: :created, location: @order }
          format.js {}
        
        else
          @order.destroy
          format.html { redirect_to action: "index"}
          format.json { render json: @order.errors, status: :unprocessable_entity }
          format.js {}
        end

      else
        format.html { render action: "order_check"}
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

end
