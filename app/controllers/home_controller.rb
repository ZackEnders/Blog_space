class HomeController < ApplicationController
	def index
		@blogs = Blog.all.order('created_at DESC')
	end
end
