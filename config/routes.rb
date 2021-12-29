Rails.application.routes.draw do
  get 'questions/destroy'
  get 'tests/destroy'
  get 'tests/new'
  get 'questions/new'
  root 'tests#index'

  resources :tests do
    resources :questions
  end
end
