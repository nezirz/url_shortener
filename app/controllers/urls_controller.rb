class UrlsController < ApplicationController
	before_action :click

	def index
		@url=Url.new
		@urls=Url.all.order("id DESC").take(10)

	end
	def create
		@url=Url.new(url_params)
		@url.short = SecureRandom.urlsafe_base64(5)
		@url.clicks = 0
		@url.active =1
		if @url.save
			redirect_to root_path
		end
	end

	private
	def url_params
		params.require(:url).permit(:url_text,:short,:clicks,:active)
	end
	def click
	    @p= request.original_url.split('/')[3]
	    if @p.present? 
			@ur=Url.find_by_short(@p)
			if @ur.present?
				@ur.update_attributes(clicks: @ur.clicks+1)
				redirect_to root_path
			end
		end
	end
end
