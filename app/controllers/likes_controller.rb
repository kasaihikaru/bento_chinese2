class LikesController < ApplicationController

	def index

	end

  def create
    like = Like.create(create_params)
    @sentence = Sentence.includes(:user).find(params[:sentence_id])
    @myfolds = current_user.folds
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    @sentence = Sentence.includes(:user).find(params[:sentence_id])
  end


#############  ストロングパラメーター  ############
  private
  def create_params
    params.permit(:sentence_id).merge(user_id: current_user.id)
  end

end