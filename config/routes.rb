Rails.application.routes.draw do
  root "welcome#index"
  get "auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resource :retirements

  resources :events do
    resources :tickets
  end
end
