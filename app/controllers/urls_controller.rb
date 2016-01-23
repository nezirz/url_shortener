class UrlsController < ApplicationController
	before_action :click

	def index
		@url=Url.new
		@urls=Url.all.order("id DESC").take(10)
		@urlvisits=Url.all.order("clicks DESC").take(10)
		#@short=request.original_url+session[:short]
		@short = request.original_url.gsub('?','')
	end
	def create
		@url=Url.new(url_params)
		@p = Url.find_by_url_text(@url.url_text)

		 binding.pry
		
		if @p.present?
			#session[:short] = @p.short
			@u=root_path+'?'+@p.short
			redirect_to @u
		else
			@url.short = SecureRandom.urlsafe_base64(5)
			@url.clicks = 0
			@url.active =1

			if @url.save

				#session[:short] = @url.short
				@u=root_path+"?"+@url.short
				redirect_to @u
				return
			end
		end
	end

	private
	def url_params
		params.require(:url).permit(:url_text,:short,:clicks,:active)
	end

	def click
	    @p= request.original_url.split('/')[3]
	    #binding.pry

			@ur=Url.find_by_short(@p)
			if @ur.present?
				@ur.update_attributes(clicks: @ur.clicks+1)
				redirect_to @ur.url_text
			end

	end
end
