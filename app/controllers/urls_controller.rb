class UrlsController < ApplicationController

	def index
		@url=Url.new
		@urls=Url.all.order("id DESC").take(10)
	end
	def create
		@url=Url.new(url_params)
		@url.short = SecureRandom.urlsafe_base64(5)
		if @url.save
			redirect_to root_path
		end
	end

	private
	def url_params
		params.require(:url).permit(:url_text,:short,:clicks,:active)
	end
end
