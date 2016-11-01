class VotesController < ApplicationController

  def create
    vote = Vote.new vote_params
    vote.user = current_user
    vote.question = question

    if vote.save
      redirect_to question_path(question), notice: "Voted!"
    else
      redirect_to question_path(question), alert: vote.error_description
    end
  end

  def update
  end

  def destroy
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

  def question
    @question ||= Question.find params[:question_id]
  end
end
