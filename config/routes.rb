Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #when receive get request with / url we invoke index action within
  #home controller
  # get '/' => 'home#index', as: :home
  root 'home#index'

  get '/auth/twitter', as: :sign_in_with_twitter
  get '/auth/twitter/callback' => 'callbacks#twitter'
  namespace :admin do
    resources :questions
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :questions, only: [:index, :show, :create]
    end
  end


  get '/contact' => 'home#contact'
  post '/contact_submit' => 'home#contact_submit'
  resources :users, only: [:create, :new]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :questions, shallow: true do
    # get :search, on: :collection
    # get :flag, on: :member
    # post :approve
    resources :answers, only: [:create, :destroy] do
      resources :comments, only: [:create, :destroy]
    end

    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :destroy, :update]

  end
  # get '/questions/new'  => 'questions#new', as: :new_question
  # post({'/questions'    => 'questions#create', as: :questions})
  # get '/questions/:id'  => 'questions#show', as: :question
  # get '/questions'      => 'questions#index'
  #
  # get '/questions/:id/edit' => 'questions#edit', as: :edit_question
  # patch '/questions/:id' => 'questions#update'
  # delete '/questions/:id' =>'questions#destroy'

end
