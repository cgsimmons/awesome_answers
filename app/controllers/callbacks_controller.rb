class CallbacksController < ApplicationController
  # def index
  #   if params[:denied]
  #     redirect_to root_path, alert: "Twitter failed to authorize."
  #   end
  # end

  def twitter

    # render plain: "hello there from callback!"
    twitter_data = request.env['omniauth.auth']
    # find user or create user if the user is not found
    user = User.find_from_oauth(twitter_data)  ||
      User.create_from_twitter_oauth(twitter_data)
    # sign in user
    session[:user_id] = user.id
    redirect_to root_path, notice: "Thanks for signing in with Twitter!"
  end

end
