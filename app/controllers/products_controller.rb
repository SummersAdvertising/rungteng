class ProductsController < ApplicationController
  layout false
  before_filter :count
  
  def count
    @count = counter()
  end
  
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end
end
