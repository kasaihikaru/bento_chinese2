class WordsController < ApplicationController

	def hide
		@word = Word.find(hide_params)
		@word.update(hide: 1)
	end

	def show
		@word = Word.find(hide_params)
		@word.update(hide: 0)
	end

	private
  def hide_params
    params[:id]
  end

end
