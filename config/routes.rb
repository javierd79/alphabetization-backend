Rails.application.routes.draw do
  resources :users, params: :_email

  post '/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
