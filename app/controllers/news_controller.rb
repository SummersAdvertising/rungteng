class NewsController < ApplicationController
  layout false
  before_filter :count
  
  def count
    @count = counter()
  end
  
  def index
    @news = News.order('created_at DESC').page(params[:page]).per(17)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end
  def show
    @news = News.find(params[:id])

    @content = JSON.parse(@news.content) if !@news.content.nil?
    @paragraphs = @content["article"]

    $meta_title = @news.name

    $meta_description = '';
    max_length = 150

    # 產出 og:description
    @paragraphs.each do | p |
      next if p["type"] != "paragraph"

      partical_content = p["content"].gsub(/<br([ \/]*)>/, "\n")
      $meta_description += partical_content
      max_length -= partical_content.length

      break if max_length <= 0
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end
end
