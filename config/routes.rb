Rails.application.routes.draw do

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  get 'sessions/new'
  get 'users/new'

  root 'tests#index'

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  #  GET /test_passages/101/result
  resources :test_passages, only: %i[show update] do
    resources :gists, only: :create
    member do
      get :result
    end

  end

  resources :badges, only: %i[index]

  resources :badges_users, only: %i[index]

  namespace :admin do
    resources :gists, only: :index
    resources :badges
    resources :tests do
      patch :update_inline, on: :member
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
  end
end
