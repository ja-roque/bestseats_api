Rails.application.routes.draw do
  post '/bestseats/show', to: 'bestseat#show', as: 'bestseats'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
