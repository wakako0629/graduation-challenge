Rails.application.routes.draw do
  get 'sessions/new'

   resources :blogs do
    collection do
      post :confirm
    end
  end 
  
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  
   if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
   end
  
end
