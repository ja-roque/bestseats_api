Rails.application.routes.draw do
  post '/bestseats/venue', to: 'bestseat#venue', as: 'venue'
  post '/bestseats/seats', to: 'bestseat#seats', as: 'seats'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
