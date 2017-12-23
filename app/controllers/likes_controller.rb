class LikesController < ApplicationController

	def index
    @user = User.find(params[:user_id])
    likes = @user.likes

    sentences = []
    likes.each do |like|
      sentence = like.sentence
      sentences << sentence
    end
    @sentences = Kaminari.paginate_array(sentences).page(params[:page]).per(20)

    @sentence = Sentence.new
    @sentence.words.build
    @fold = Fold.new
    @folds = @user.folds

    if user_signed_in?
      @myfolds = current_user.folds
    end

    @redirect_type = 2
    @redirect_id = params[:user_id]
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