Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get "/messages", to: "contacts#index"
  get "/messages/:id", to: "contacts#show"
  post "/messages", to: "contacts#create"
  delete "/messages/:id", to: "contacts#destroy"

end
