class BlogsController < ApplicationController

  def show
    @blog = Blog.find(params[:id])
  end

  def new
  end

	def index
    @blogs = Blog.paginate(page: params[:page])
		#@blogs=Blog.all
	end
end
