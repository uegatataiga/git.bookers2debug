class Book < ApplicationRecord

  belongs_to :user
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length:{maximum:200}
  validates :category, presence: true


  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}

 #検索機能
 def self.looks(search, word)
    if search == "perfect_match"
       @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
       @book = Book.where("title LIKE?","#{word}")
    elsif search == "backword_math"
       @book = Book.where("title LIKE?","#{word}")
    elsif search == "partial_match"
       @book = Book.where("title LIKE?","#{word}")
    else
       @book = Book.all
    end
 end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


end
