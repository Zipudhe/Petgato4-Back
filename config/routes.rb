Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Rotas da Comments controller
  resources :comments
  
  # Rotas da Replies controller
  resources :replies
  
  # Rotas da TagPosts controller
  resources :tag_posts
  
  # Rotas da Reports controller 
  resources :reports
  
  # Rotas da Contacts controller
  get "/messages", to: "contacts#index"
  get "/messages/:id", to: "contacts#show"
  post "/messages", to: "contacts#create"
  delete "/messages/:id", to: "contacts#destroy"

  # Rotas da Users controller
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  post "/users", to: "users#create"
  put "/users/:id", to: "users#update"
  delete "users/:id", to: "users#destroy"

  # Rotas da Likes controller
  get "/likes", to: "likes#index"
  get "/likes/user/:user_id", to: "likes#userlikes"
  get "/likes/post/:post_id", to: "likes#postlikes"
  post "/likes", to: "likes#create"

end
