class StaticpageController < ApplicationController
  layout false
	def index		
	end
	def home
		@count = Guestcount.first
		if(@count.blank?)
			@count = Guestcount.new
			@count.count = 1			
		else
			@count.count += 1
		end

		@count.save
	end
end
