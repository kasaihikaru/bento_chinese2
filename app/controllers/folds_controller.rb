class FoldsController < ApplicationController

	def show
		@sentence = Sentence.new
		@fold_id = params[:id]
		@sentence.words.build

			@current_fold = Fold.find(params[:id])
			fold_user_id = @current_fold.user_id
		@user = User.find(fold_user_id)
		@fold = Fold.new
		@folds = @user.folds

		@foldsentences = @current_fold.sentences.where(hide: 0).order("created_at DESC")



	end

	def create
		just_created_fold = Fold.create(create_params)
		redirect_to fold_path(just_created_fold.id)
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