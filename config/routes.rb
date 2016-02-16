Rails.application.routes.draw do
  resources :scrapes
  resources :scrapes
  root to: "scrapes#index"
end
