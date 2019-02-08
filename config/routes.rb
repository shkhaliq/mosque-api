Rails.application.routes.draw do
  resources :mosques do
    resources :salahs
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end