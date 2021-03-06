class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@sentences = @user.sentences.includes(:user).order("created_at DESC").page(params[:page]).per(20)

		@sentence = Sentence.new
		@sentence.words.build
		@fold = Fold.new
		@folds = @user.folds.active

		# @wordfold = WordFold.new

		if user_signed_in?
			@myfolds = current_user.folds.active
		end

		@redirect_type = 1
		@redirect_id = params[:id]
	end

end