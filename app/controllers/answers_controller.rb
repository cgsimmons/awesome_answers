class AnswersController < ApplicationController
  before_action :authenticate_user

  def create
    @question        = Question.find params[:question_id]
    answer_params    = params.require(:answer).permit(:body)
    @answer          = Answer.new answer_params
    @answer.question = @question
    @answer.user     = current_user
    respond_to do |format|
      if @answer.save
        format.js {render :create_success}
        format.html do
          redirect_to question_path(@question), notice: 'Answer created!'
        end
      else
        format.js {render :create_failure}
        format.html {render 'questions/show'}
      end
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    respond_to do |format|

      if can? :destroy, @answer
        question = @answer.question
        @answer.destroy
        format.html { redirect_to question, notice: 'Answer deleted!'}
        format.js { render }  #destroy.js.erb by default
      else
        format.html { redirect_to root_path, alert: 'Access Denied'}
        format.js { render js: 'alert("Access denied.")'; }
      end

    end
  end

end
