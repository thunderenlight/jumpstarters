class CommentsController < ApplicationController
	
	# def index
	# 	@comments = Comment.all
	# end

	# def show
	# 	@article = Article.find(params[:id])
	# end

	def new
		# @article = Article.new
		@comment = Comment.new
		# @comment.article_id = @article.id
	end
	def create
	  # @comment = Comment.new(comment_params)
	  article = Article.find(params[:comment][:article_id])
	  comment = article.comments.create(comment_params) 
	  # @comment.save

	  redirect_to article_path(@comment.article)
	end
	private

	def comment_params
	  params.require(:comment).permit(:article_id, :author_name, :body)
	end


end
