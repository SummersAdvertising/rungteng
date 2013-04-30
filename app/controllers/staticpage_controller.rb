class StaticpageController < ApplicationController
  layout false
  before_filter :count
  
  def count
    @count = counter()
  end
  
end
