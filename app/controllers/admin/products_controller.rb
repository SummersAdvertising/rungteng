class Admin::ProductsController < ApplicationController
  before_filter :require_is_admin
  layout 'admin'
  def index
    @products = Product.where("producttype = ?", "item").order('ordernum ASC, updated_at DESC, created_at DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def index_box
    @products = Product.where("producttype = ?", "box").order('ordernum ASC, updated_at DESC, created_at DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  def new_box
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def edit_box
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    @product.producttype = "item"

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_products_path, notice: 'product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_box
    @product = Product.new(params[:product])
    @product.producttype = "box"

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_boxs_path, notice: 'product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    flash[:notice] = 'successfully updated.'

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to admin_product_path(@product), notice: 'product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.admindelete = true;
    @product.save

    respond_to do |format|
      format.html { redirect_to admin_products_url }
      format.json { head :no_content }
    end
  end
end
