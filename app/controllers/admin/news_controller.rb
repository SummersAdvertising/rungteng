class Admin::NewsController < ApplicationController
  before_filter :require_is_admin
  layout 'admin'
  def index
    @news = News.order('created_at DESC').page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def show
    @news = News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  def edit
    @news = News.find(params[:id])
    @news.frontshow = 0
    @news.save

    @photo = Newsphoto.new
  end

  def createPhoto
    @news = News.find(params[:news_id])
    @photo = @news.newsphotos.new(params[:newsphoto])

    respond_to do |format|
      if @photo.save
        #format.html { redirect_to photos.path } #index.html.erb
        format.json { render json: @photo, status: :created, location: @photo }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroyPhoto
    @photo = Newsphoto.find(params[:id])
    #File.delete("/public" + @photo.image) #carrierwave will handle this.
    @photo.destroy

    respond_to do |format|
          #format.html { redirect_to :controller => 'photos', :action => 'index' }
          format.js
          format.json { head :no_content }
      end
  end

  def create
    @news = News.new(params[:news])
    @news.frontshow = false

    respond_to do |format|
      if @news.save
        format.html { redirect_to edit_admin_news_path(@news), notice: 'News was successfully created.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to admin_news_path(@news), notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to admin_news_index_path }
      format.json { head :no_content }
    end
  end
end
