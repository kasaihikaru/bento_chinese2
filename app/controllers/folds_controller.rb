class FoldsController < ApplicationController

	def show
		@sentence = Sentence.new
		@fold_id = params[:id]
		@sentence.words.build

			@current_fold = Fold.find(params[:id])
			@current_fold_user_id = @current_fold.user_id
		@user = User.find(@current_fold_user_id)
		@fold = Fold.new
		@myfolds = @user.folds

		@foldsentences = @current_fold.sentences.where(hide: 0).order("created_at DESC").page(params[:page]).per(20)

		@redirect_type = 3
		@redirect_id = params[:id]

	end

	def create
		Fold.create(create_params)
		@myfolds = current_user.folds
	end

	def edit

	end

	def destroy

	end


###############ストロングパラメーター#############
	private
	def create_params
		params.require(:fold).permit(:name).merge(user_id: current_user.id)
	end

end