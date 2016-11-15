class QuestionsController < ApplicationController
  #perform method before actions
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_question, only: [:edit, :update, :destroy, :show]
  before_action :authorize_access, only: [:edit, :update, :destroy]

  def new
    @question = Question.new
  end

  def create
    #Question.create params[:question] failed access
    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = current_user.oauth_token
        config.access_token_secret = current_user.oauth_secret
      end
      client.update @question.title
      # flash[:notice] = 'Question Created'
      redirect_to question_path(@question), notice: 'Question Created'
    else
      flash.now[:alert] = 'Please see errors below!'
      render :new
    end
  end

  def show
    @answer = Answer.new
    @like = @question.like_for(current_user)
    respond_to do |format|
      format.html {render}
      format.text {render}
      format.xml {render xml: @question}
      format.json {render json: @question.to_json}
    end
  end

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html {render}
      format.text {render}
      format.xml {render xml: @questions}
      format.json {render json: @questions.to_json}
    end
  end

  def edit
  end

  # Capture the parameters from the form submission
  # from the edit action in order to update a question
  # URL: /questions/:id/update
  # METHOD: PATCH
  def update
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  #Destroy questions action
  #URL: /questoions/:id/destroy
  #METHOD: PATCH
  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question deleted'
  end

  private
  def question_params
    params.require(:question).permit([:title, :body, :tweet_this, tag_ids: []])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def authorize_access
    unless can? :manage, @question
    # unless (current_user == @question.user || current_user.admin?)
      # head :unauthorized # this will send an empty HTTP response with 401 code
      redirect_to root_path, alert: 'Access Denied'
    end
  end
end
