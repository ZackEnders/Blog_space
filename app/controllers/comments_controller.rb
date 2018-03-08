class CommentsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

  	def index
   		@comments = Comment.all
  	end

	def new
		@comment = Comment.new
	end

	def create
    	@comment = Comment.new(comment_params)
    		#if the blog is saved it creates the blog with the current blog params. Then alerts the user if it was successful
    		if @comment.save
    		  flash[:notice] = "Comment created successfully"
    		  redirect_to "/blogs/#{@comment.blog_id}"
    		end
	end
	def edit
		@comment = Comment.find(params[:id])
		@blog = Blog.find(@comment.blog_id)
    		if current_user.id == @comment.user_id

      		else 
      			flash[:notice] = "Access Denied"
      			redirect_to root_path
    		end
	end
	def update
  		
		#finds the blog by its id number
    	@comment = Comment.find(params[:id])
    	#if the blog is updated it stores the blog_params and alerts the user that it was updated
    		if @comment.update(comment_params) && @comment.user_id == current_user.id
      			flash[:notice] = "Comment updated!"
      			redirect_to "/blogs/#{@comment.blog_id}"
    		else
      			flash[:notice] = "Comment update unsuccessful!"
      			render edit_blog_comment_path
   			end
	end

	def destroy
		# finds the blog by it's id number
    	@comment = Comment.find(params[:id])
    	#if blog destroy is successful then it alerts the user that it was deleted
    		if @comment.destroy
      			flash[:notice] = "Comment deleted!"
      			redirect_to "/blogs/#{@comment.blog_id}"
    		else
      			flash[:notice] = "Could not delete comment!"
      			render blog_path
			end
	end

	def comment_params
        params.require(:comment).permit(:body, :blog_id, :user_id)
    end


end
