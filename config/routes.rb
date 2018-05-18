Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :lectures do
    member do
      get :download
      post :comment
      put "like", to: "lectures#upvote"
    put "dislike", to: "lectures#downvote"
    put "spam", to: "lectures#spam_lecture"

    end
  end
  resources :courses
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
