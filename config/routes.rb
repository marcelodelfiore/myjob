Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#login'
      delete 'auth/logout', to: 'authentication#logout'

      resources :jobs
      resources :recruiters
      resources :submissions
    end
  end
end
