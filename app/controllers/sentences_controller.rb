class SentencesController < ApplicationController

	def index
		@sentences = Sentence.includes(:user).order("created_at DESC").page(params[:page]).per(20)
		if user_signed_in?
			@myfolds = current_user.folds
		end

		@fold = Fold.new
		@sentence = Sentence.new
		@sentence.words.build
	end



#############新しい文章の作成###############
	def create
		Sentence.create(sentence_params)

		words = words_params
		words.each do |w|
			Word.create("ja"=>w[:ja], "ch"=>w[:ch], "pin"=>w[:pin], "sentence_id"=>w[:sentence_id])
		end

		@sentence = Sentence.new
		@sentence.words.build
		if user_signed_in?
			@myfolds = current_user.folds
		end
		redirect_to root_path
		# redirect_to fold_path(params[:sentence]["fold_id"])
	end




	def edit

	end

	def destroy

	end

	def update

	end



###############覚えたボタン、全文章表示ボタン#############
	def memorized
		sentence = Sentence.find(memorized_params)
		sentence.update( hide: 1 )

		current_fold = Sentence.find(params[:sentence_id]).fold
		@foldsentences = current_fold.sentences.where(hide: 0).order("created_at DESC")
	end

	def show_all
		current_fold = Fold.find(show_all_params)
		sentences = current_fold.sentences
		sentences.update_all(hide: 0)

		redirect_to fold_path(current_fold.id)
	end



###############ストロングパラメーター#############
	private
	def sentence_params
		pin = PinYin.of_string(params[:sentence][:ch], :unicode)
		if pin.count == 1
			pinyin = pin.first
		else
			pinyin = ""
			pin.each do |p|
				pinyin += "#{p} "
			end
		end
		params.require(:sentence).permit(:fold_id, :ja, :ch).merge(user_id: current_user.id, pin: pinyin)
	end

	def words_params
		id = Sentence.last.id
		array = []

		params[:sentence][:words_attributes].each do |key,value|
			if value["ja"].present? && value["ch"].present?
					value[:sentence_id] = id

					pin = PinYin.of_string(value[:ch], :unicode)
						if pin.count == 1
							pinyin = pin.first
						else
					pinyin = ""
					pin.each do |p|
						pinyin += "#{p} "
					end
				end
				value[:pin] = pinyin

				array << value
			else
				next
			end
		end
		return array
	end



	def memorized_params
		id = params[:sentence_id]
		return id
	end


def show_all_params
		id = params[:fold]
		return id
end


end