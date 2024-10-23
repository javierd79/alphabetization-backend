Rails.application.routes.draw do
  resources :users, params: :_email
  resources :subjects do 
    get 'reports', on: :collection
    get 'available', on: :collection
    post 'add_user', on: :collection
  end

  post '/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
