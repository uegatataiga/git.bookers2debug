class Book < ApplicationRecord

  belongs_to :user
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  has_many :book_comments, dependent: :destroy
  has_many :read_counts, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length:{maximum:200}
  validates :category, presence: true


  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }

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
