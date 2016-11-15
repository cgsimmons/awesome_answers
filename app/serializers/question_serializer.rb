class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :answers_count, :user

  has_many :answers

  def answers_count
    object.answers.count
  end

  def user
    {first_name: object.user_first_name, last_name: object.user_last_name}
  end
end
