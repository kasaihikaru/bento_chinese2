class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

	has_many :folds
	has_many :sentences
	has_many :likes

	# ファイルアップロード処理
	mount_uploader :image, ImageUploader


	def sentence_like(sentence_id)
		current_user.likes.where(sentence_id: sentence_id).select(:id)
	end


  # @return [Boolean] cookieを使いログイン情報を保持するかどうか -> ここではtrue
  # つけておくと、ブラウザ閉じてもログイン保持できる
  def remember_me
    true
  end

end