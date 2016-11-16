class AnswersMailer < ApplicationMailer

  def notify_question_owner(answer)
    @question = answer.question
    @user = @question.user

    mail(to: @user.email, subject: "You got an answer to your question.") if @user && @user.email
  end
end
