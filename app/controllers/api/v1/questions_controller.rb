class Api::V1::QuestionsController < Api::BaseController

  def index
    @questions = Question.order(created_at: :desc).limit(10)
    # render json: questions.to_json
    # would bypass templates so comment out
  end

  def show
    question = Question.friendly.find(params[:id])
    render json: question
  end

  def create
    question_params = params.require(:question).permit(:title, :body)
    question = Question.new question_params
    question.user = @api_user
    if question.save
      render json: {id: question.id, status: :success}
    else
    render json: {status: :failure, errors: question.errors.full_messages}
    end
  end

end
