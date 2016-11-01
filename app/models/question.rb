class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, -> { order(created_at: :DESC) }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  validates :title, presence: true, uniqueness: {case_sensative: false,
                                                 message: 'must be unique'}
  validates :body, length: { minimum: 5},
                   uniqueness: { scope: :title }
  validates :view_count, numericality: {greater_than_or_equal_to: 0}
  after_initialize :set_defaults
  before_validation :titleize_title

  def self.recent_ten
    limit(10).order(created_at: :desc)
  end

  def user_full_name
    if user
      user.full_name
    else
      'Anonymous'
    end
  end

  def like_for(user)
    likes.find_by(user: user)
  end

  private
  def set_defaults
    self.view_count ||=0
  end
  def titleize_title
    self.title = self.title.titleize if title.presence
  end
end
