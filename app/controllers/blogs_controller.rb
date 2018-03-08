class BlogsController < ApplicationController
	before_action :authenticate_user!

  # List all blogs from most recent
	def index
		@blogs = Blog.all.order('created_at DESC')
	end

	def new
		@blog = Blog.new
	end

	def create
		@user = User.find(current_user.id)

    		blog = Blog.new(blog_params)
    		#if the blog is saved it creates the blog with the current blog params. Then alerts the user if it was successful
    		if blog.save
    		  flash[:notice] = "Blog created successfully"
    		  redirect_to blogs_path
    		else
    		  flash[:notice] = "Blog creation unsuccessful! Please try again!"
    		  render new_blog_path
    		end

	end

  #Show current blog and all comments

	def show
		@blog = Blog.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all

  	end

# only allows the current user to edit their blog
	def edit
		@blog = Blog.find(params[:id])

    		if current_user.id == @blog.user_id

      		else 
      			flash[:notice] = "Access Denied"
      			redirect_to root_path

    		end
	end

	def update
  		
		#finds the blog by its id number
    	@blog = Blog.find(params[:id])
    	#if the blog is updated it stores the blog_params and alerts the user that it was updated
    		if @blog.update(blog_params) && @blog.user_id == current_user.id
      			flash[:notice] = "Blog post updated!"
      			redirect_to blog_path
    		else
      			flash[:notice] = "Blog update unsuccessful!"
      			render edit_blog_path
   			end
	end

	def destroy

    	blog = Blog.find(params[:id])
    	#if blog destroy is successful then it alerts the user that it was deleted
    		if blog.destroy
      			flash[:notice] = "Blog post deleted!"
      			redirect_to root_path
    		else
      			flash[:notice] = "Could not delete blog post!"
      			render blog_path
			end
	end

	private 

  		def blog_params
  		  params.require(:blog).permit(:title, :content, :user_id)
  		end
    
  

end
