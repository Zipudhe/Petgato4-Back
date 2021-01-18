Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Rotas do Posts controller
  get "/posts", to: "posts#index"
  get "/posts/:id", to: "posts#show"
  post "/posts", to: "posts#create"
  put "/posts/:id", to: "posts#update"
  delete "posts/:id", to: "posts#destroy"
  get "/allposts", to: "posts#posts"
  get "/countposts", to: "posts#countposts"

  # Rotas da Tags controller
  resources :tags
  get "/alltags", to: "tags#tags"
  get "/countags", to: "tags#countags"

  # Rotas da Comments controller
  resources :comments
  
  # Rotas da Replies controller
  resources :replies
  
  # Rotas da TagPosts controller
  resources :tag_posts
  get "/tag_posts/tags/:id", to: "tag_posts#postags"  # tags de um post
  #get "/tag_posts/posts/:id", to: "tag_posts#postags" # posts de uma tag
  get "countagposts/:tag_id", to: "tag_posts#countagposts"

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

  # Rota de autenticação
  post "/auth/login", to: "authentication#login"
  get "/is_token_valid", to: "authentication#is_token_valid"
  get "/is_admin", to: "authentication#is_admin"

  # Rotas da Likes controller
  get "/likes", to: "likes#index"
  get "/likes/user/:user_id", to: "likes#userlikes"
  get "/likes/post/:post_id", to: "likes#postlikes"
  post "/likes", to: "likes#create"

end
