class ArticlesController < ApplicationController
	respond_to :html, :json, :xml
	include ArticlesHelper

	def index
		@articles, @tag = Article.search_by_tag_name(params[:tag])
		respond_with(@articles, @tag)
	end

	def show
		@article = Article.find(params[:id])
		
	end

	def new
		@article = Article.new
		# @comment = Comment.new
		# @comment.article_id = @article.id
	end

	def create
		@article = Article.new(article_params)
		flash[:notice] = @article.save ? "Article was created" : "Article was not created"
		respond_with @article 
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end
	def edit
		@article = Article.find(params[:id])
	end
	def update
		@article = Article.find(params[:id])
		@article.update(article_params)
		flash.notice = "Article '#{@article.title}' Updated!"
		redirect_to article_path(@article)
	end
	private

	def article_params
		params.require(:article).permit(:title, :body, :tag_list, :image)
	end



end
