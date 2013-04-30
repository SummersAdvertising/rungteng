class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :clear_setting
  
  def require_is_admin
  	unless(session[:admin])
  		redirect_to admin_log_in_path
  	end
  end

  def clear_setting  	
	  $meta_title = nil
	  $meta_description = nil
  end

  def counter
    @count = Guestcount.first
    if(@count.blank?)
      @count = Guestcount.new
      @count.count = 1
    end
    
    return @count
  end
end
