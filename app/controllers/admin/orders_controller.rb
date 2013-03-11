class Admin::OrdersController < ApplicationController
  before_filter :require_is_admin
  layout 'admin'
  def index
    @orders = Order.order('created_at DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.isAdminCheck = params[:order][:isAdminCheck]

    respond_to do |format|
      if @order.save
        format.html { redirect_to admin_order_path(@order), notice: 'order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @@order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to admin_orders_path }
      format.json { head :no_content }
    end
  end
  
end
