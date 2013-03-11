class NewsController < ApplicationController

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
end
