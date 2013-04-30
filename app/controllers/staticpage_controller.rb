class StaticpageController < ApplicationController
  layout false
  before_filter :count, :except => [:index]
  
  def count
    @count = counter()
  end

  def home
  	@count.count += 1
  	@count.save
  end
  
end
