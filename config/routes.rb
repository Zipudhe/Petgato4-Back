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
  get "/popularposts", to: "posts#popularposts"
  get "/searchposts", to: "posts#search_posts"

  # Rotas da Tags controller
  resources :tags
  get "/alltags", to: "tags#tags"
  get "/countags", to: "tags#countags"

  # Rotas da Comments controller
  resources :comments
  get "/comments_count/:post_id", to: "comments#count_comments"
  get "/comments_by_post/:post_id", to: "comments#comments_by_post"

  # Rotas da Replies controller
  resources :replies
  get "/replies_by_comment/:comment_id", to: "replies#replies_by_comment"
  
  # Rotas da TagPosts controller
  resources :tag_posts
  #get "/tag_posts/tags/:id", to: "tag_posts#postags" # posts de uma tag
  get "/countagposts/:tag_id", to: "tag_posts#countagposts"
  get "/tagsbypost/:post_id", to: "tag_posts#tagsbypost"
  get "/postsbytag/:tag_id", to: "tag_posts#postsbytag"
  put "/edit_tagpost", to: "tag_posts#add_remove"

  # Rotas da Reports controller 
  resources :reports
  get "/reports_all", to: "reports#allreports"
  get "/report_count", to: "reports#report_all_count"
  get "/isreported/:comment_id/:reply_id", to: "reports#isreported"
  get "/isreportedcomment/:comment_id", to: "reports#isreportedcomment"

  # Rotas da Contacts controller
  get "/messages", to: "contacts#index"
  get "/messages/:id", to: "contacts#show"
  post "/messages", to: "contacts#create"
  delete "/messages/:id", to: "contacts#destroy"
  get "/messages_all", to: "contacts#allcontacts"
  get "/messages_count", to: "contacts#contacts_count"

  # Rotas da Users controller
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  post "/users", to: "users#create"
  put "/users/:id", to: "users#update"
  delete "users/:id", to: "users#destroy"
  get "users_all", to: "users#allusers"
  get "users_count", to: "users#users_count"

  # Rota de autenticação
  post "/auth/login", to: "authentication#login"
  get "/is_token_valid", to: "authentication#is_token_valid"
  get "/is_admin", to: "authentication#is_admin"

  # Rotas da Likes controller
  get "/likes", to: "likes#index"
  get "/likes/:user_id/:post_id", to: "likes#userliked"
  delete "/likes/:user_id/:post_id", to: "likes#destroy"
  get "/countlikespost/:post_id", to: "likes#postlikes"
  post "/likes", to: "likes#create"

end
