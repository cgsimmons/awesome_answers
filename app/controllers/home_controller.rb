class HomeController < ApplicationController

  #this method is called 'action'
  def index
    #render views/home/index.html.erb and use
    #views/layouts/application.html.erb
    #line below is implied by convention
    #render :index
    cookies[:last_visited] = Time.now
    cookies[:lucky_number] = rand(100)
  end

  def contact
  end

  def contact_submit
    @name = params[:full_name]
  end

end
