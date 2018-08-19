Rails.application.routes.draw do
  devise_for :users
	root to: "sentences#index"

	resources :users, only: [:show] do  #ユーザーページ
		resources :likes, only: [:index, :create, :destroy]  #あるユーザーのお気に入り一覧ページ
	end

	resources :sentences, only: [:index, :create, :edit, :destroy, :update] do  #TOPタイムライン、編集ページ
		collection do
			patch 'memorized' #覚えたボタン
			patch 'show_all' #全表示ボタン
			post 'copy' #コピーボタン
		end
		resources :likes, only: [:create, :destroy]
	end

	resources :folds, only: [:show, :create, :edit, :destroy] do
		# resources :words, only: [:index]
		get 'words'
		get 'words_c_to_j'
	end

	put '/words_hide'      => 'words#hide'
	put '/words_show'      => 'words#show'
	put '/words_hide_c_to_j'      => 'words#hide_c_to_j'
	put '/words_show_c_to_j'      => 'words#show_c_to_j'


	resources :abouts, only: [:index] #サービス説明ページ

end