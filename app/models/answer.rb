class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: {minimum: 5}

  def user_full_name
    user ? user.full_name : 'Anonymous'
  end
end
