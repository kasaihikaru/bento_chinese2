class SentencesController < ApplicationController

	def index
		@sentences = Sentence.includes(:user).order("created_at DESC").page(params[:page]).per(20)
		if user_signed_in?
			@myfolds = current_user.folds.active
		end

		@fold = Fold.new
		@sentence = Sentence.new
		@sentence.words.build

		@redirect_type = 0
		@redirect_id = 0
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
			@myfolds = current_user.folds.active
		end

		redirect_flg = redirect_params
		if redirect_flg[:redirect_type] == "0" then
			redirect_to root_path
		elsif redirect_flg[:redirect_type] == "1" then
			redirect_to user_path(params[:sentence]["redirect_id"])
		elsif redirect_flg[:redirect_type] == "2" then
			redirect_to user_likes_path(params[:sentence]["redirect_id"])
		elsif redirect_flg[:redirect_type] == "3" then
			redirect_to fold_path(params[:sentence]["redirect_id"])
		else
			redirect_to root_path
		end
	end




	def edit
		@original_sentence = Sentence.find(params[:id])
		@original_sentence.words.build
	end

	def destroy

	end

	def update
		original_sentence = Sentence.find(update_params)

		original_sentence.update(user_id:update_sentence_params[:user_id], fold_id:update_sentence_params[:fold_id], ja:update_sentence_params[:ja], ch:update_sentence_params[:ch], pin:update_sentence_params[:pin] )
		words = update_words_params
		words.each do |w|
			if w[:id].present?
				original_word = Word.find(w[:id])
				original_word.update("ja"=>w[:ja], "ch"=>w[:ch], "pin"=>w[:pin], "sentence_id"=>update_params)
			else
				Word.create(ja: w[:ja], ch: w[:ch], sentence_id: w[:sentence_id], pin: w[:pin])
			end
		end

		update_new_words_params.each do |w|
			if w[:ja].present? && w[:ch].present?
				pin = PinYin.of_string(w[:ch], :unicode)
				if pin.count == 1
					pinyin = pin.first
				else
					pinyin = ""
					pin.each do |p|
						pinyin += "#{p} "
					end
				end
				Word.create(ja: w[:ja], ch: w[:ch], sentence_id: original_sentence.id, pin: pinyin)
			end
		end

		redirect_to fold_path(sentence_params[:fold_id])
	end



###############覚えたボタン、全文章表示ボタン、コピーボタン#############
	def memorized
		sentence = Sentence.find(memorized_params)
		sentence.update( hide: 1 )

		current_fold = Sentence.find(params[:sentence_id]).fold
		@foldsentences = current_fold.sentences.where(hide: 0).order("created_at DESC").page(params[:page]).per(20)
	end

	def show_all
		current_fold = Fold.find(show_all_params)
		sentences = current_fold.sentences
		sentences.update_all(hide: 0)

		redirect_to fold_path(current_fold.id)
	end

def copy
	sentence_id = params[:sentence]
	fold_id = params[:fold]
	user_id = Fold.find(fold_id).user_id

	ori_sen = Sentence.find(sentence_id)

	Sentence.create("ja"=>ori_sen[:ja], "ch"=>ori_sen[:ch], "pin"=>ori_sen[:pin],"hira"=>ori_sen[:hira], "fold_id"=>fold_id, "user_id"=>user_id)

	just_created_sentence = Sentence.last
	words = ori_sen.words
	words.each do |w|
		Word.create("ja"=>w[:ja], "ch"=>w[:ch], "pin"=>w[:pin], "sentence_id"=>just_created_sentence.id)
	end

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

	def redirect_params
		redirect_flg = params.require(:sentence).permit(:redirect_id, :redirect_type)
		return redirect_flg
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


	def update_sentence_params
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

	def update_params
		params.require(:id)
	end

	def update_words_params
		id = params[:id]
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

	def update_new_words_params
		params.require(:new_words)
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