class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@sentences = @user.sentences.includes(:user).order("created_at DESC").page(params[:page]).per(20)

		@fold = Fold.new
		@folds = @user.folds

		if user_signed_in?
			@myfolds = current_user.folds
		end
	end

end