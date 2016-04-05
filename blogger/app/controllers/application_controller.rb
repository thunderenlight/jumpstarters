class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method(:current_author)


  def current_author
  	Author.find_by_id session[:author_id]
  end

  def require_author
  	unless current_author
  		redirect_to login_path, notice: "You must be logged in to there"
  	end
  end
end
