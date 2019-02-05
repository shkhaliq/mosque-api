Rails.application.routes.draw do
  resources :mosques do
    resources :salahs
  end
end