class BlogsController < ApplicationController
  before_action :authenticate, except:[ :index, :show ]
  def show
    @blog = Blog.find(params[:id])
  end

  def new
		@blog = Blog.new
  end

 	def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(blog_params)
      flash[:success] = "Blog updated"
      redirect_to @blog
    else
      render 'edit'
    end
  end

	def edit
		    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)    # Not the final implementation!
    if @blog.save

			flash[:success] = "New Post!"
      redirect_to @blog
    else
      render 'new'
    end
  end

	def index
    @blogs = Blog.paginate(page: params[:page])
		#@blogs=Blog.all
	end

private

    def blog_params
      params.require(:blog).permit(:title, :author, :body)
    end

	  private
  	
		def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == "admin" && password == "secret"
    end
  end
end
