Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#login'
      delete 'auth/logout', to: 'authentication#logout'

      resources :recruiters do
        resources :jobs do
          resources :submissions
        end
      end

      namespace :publica do
        resources :active_jobs, only: [:index]
        resources :search, only: [:index]
        resources :job_detail, only: [:show]
        resources :new_submission, only: [:create]
      end
    end
  end
end
