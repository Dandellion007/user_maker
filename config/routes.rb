Rails.application.routes.draw do
  resources :users, only: %i[index show create destroy]
  resources :skills, only: %i[index show create destroy]
  resources :interests, only: %i[index show create destroy]

  get 'up' => 'rails/health#show', as: :rails_health_check
end
