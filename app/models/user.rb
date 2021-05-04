class User < ApplicationRecord
  attachment :post_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  attachment :profile_image

  # バリデーション設定
  validates :name, length: {in: 2..20} , uniqueness: true
  validates :introduction, length: {maximum: 50}
end
