Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/likes", to: "likes#index"
  get "/likes/user/:user_id", to: "likes#userlikes"
  get "/likes/post/:post_id", to: "likes#postlikes"
  post "/likes", to: "likes#create"
end
