class WordsController < ApplicationController

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

end
