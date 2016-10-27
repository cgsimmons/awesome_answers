class LikesController < ApplicationController
  before_action :authenticate_user
  
  def create
    question = Question.find(params[:question_id])
    like = Like.new(user: current_user, question: question)

    if like.save
      redirect_to :back, notice: '💕You have liked the question!💕'
    else
      redirect_to :back, alert:  like.errors.full_messages.join(', ')
    end
  end

  def destroy
    like = Like.find(params[:id])

    if like.destroy
      redirect_to :back, notice: '💔You have un-liked the question.💔'
    else
      redirect_to :back, alert: like.errors.full_messages.join(', ')
    end
  end
end
