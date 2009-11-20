ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.resources :password_resets
  map.resource  :user_session
  map.resources :users
  map.resource  :dashboard, :controller => "dashboard"
  
  
  map.register '/register/:activation_code',  :controller => 'activations', :action => 'new'
  map.activate '/activate/:id',               :controller => 'activations', :action => 'create'
  map.activations '/activations',             :controller => 'activations'
  
  map.signup "/signup", :controller => "users", :action => "new"
  map.login "/login", :controller => "user_sessions", :action => "new"
  map.logout "/logout", :controller => "user_sessions", :action => "destroy"

  map.root :controller =>"public_pages", :action => "home"

end
