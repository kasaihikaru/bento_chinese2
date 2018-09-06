class WordsController < ApplicationController

	def edit
		@word = Word.find(params[:id])
		@redirect_flg = redirect_params
	end

	def update
		pin = PinYin.of_string(update_params[:ch], :unicode)
		if pin.count == 1
			pinyin = pin.first
		else
			pinyin = ""
			pin.each do |p|
				pinyin += "#{p} "
			end
		end

		word = Word.find(id_params)
		word.update("ja"=>update_params[:ja], "ch"=>update_params[:ch], "pin"=>pinyin)
		
		if redirect_params == "0"
			redirect_to fold_words_path(word.sentence.fold)
		else
			redirect_to fold_words_c_to_j_path(word.sentence.fold)
		end
	end

	def hide
		@word = Word.find(hide_params)
		@word.update(hide: 1)
	end

	def show
		@word = Word.find(hide_params)
		@word.update(hide: 0)
	end

	def hide_c_to_j
		@word = Word.find(hide_params)
		@word.update(hide_c_to_j: 1)
	end

	def show_c_to_j
		@word = Word.find(hide_params)
		@word.update(hide_c_to_j: 0)
	end


	private
  def hide_params
    params[:id]
  end

	def update_params
    params.require(:word)
	end
	
	def id_params
		params.require(:id)
	end

	def redirect_params
		params[:redirect_flg]
	end

end
