class CommentsController < ApplicationController
	
	def index
		# @articles = Article.all
	end

	def show
		# @article = Article.find(params[:id])
	end

	def new
		# @article = Article.new
		# @comment = Comment.new
		# @comment.article_id = @article.id
	end
	def create
	  @comment = Comment.new(comment_params)
	  @comment.article_id = params[:article_id]

	  @comment.save

	  redirect_to article_path(@comment.article)
	end

	def comment_params
	  params.require(:comment).permit(:author_name, :body)
	end


end
