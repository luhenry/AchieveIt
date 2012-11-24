Achieveit::Application.routes.draw do
  resources :projects

  root to: 'homepage#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get    'sign-in',  :to => 'devise/sessions#new',     :as => :new_user_session
    delete 'sign-out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  devise_for :developers, path: 'admin', controllers: {registrations: "developers/registrations", sessions: "developers/sessions"}

  resources :users

  resources :developer_projects

  resources :developers

  get    'projects(.:format)'            => 'projects#index'
  get    'projects/:slug(.:format)'      => 'projects#show'
  get    'projects/new(.:format)'        => 'projects#new'
  post   'projects(.:format)'            => 'projects#create'
  get    'projects/:slug/edit(.:format)' => 'projects#edit'
  put    'projects/:slug(.:format)'      => 'projects#update'
  delete 'projects/:slug(.:format)'      => 'projects#destroy'

  get    'steps/:project_slug/:achievement_slug(.:format)'            => 'achievement_steps#index'
  get    'steps/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#show'
  get    'steps/:project_slug/:achievement_slug/new(.:format)'        => 'achievement_steps#new'
  post   'steps/:project_slug/:achievement_slug(.:format)'            => 'achievement_steps#create'
  get    'steps/:project_slug/:achievement_slug/:slug/edit(.:format)' => 'achievement_steps#edit'
  put    'steps/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#update'
  delete 'steps/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#destroy'

  get    'levels/:project_slug/:achievement_slug(.:format)'            => 'achievement_steps#index'
  get    'levels/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#show'
  get    'levels/:project_slug/:achievement_slug/new(.:format)'        => 'achievement_steps#new'
  post   'levels/:project_slug/:achievement_slug(.:format)'            => 'achievement_steps#create'
  get    'levels/:project_slug/:achievement_slug/:slug/edit(.:format)' => 'achievement_steps#edit'
  put    'levels/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#update'
  delete 'levels/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#destroy'

  get    'achievements/:project_slug(.:format)'            => 'achievements#index'
  get    'achievements/:project_slug/:slug(.:format)'      => 'achievements#show'
  get    'achievements/:project_slug/new(.:format)'        => 'achievements#new'
  post   'achievements/:project_slug(.:format)'            => 'achievements#create'
  get    'achievements/:project_slug/:slug/edit(.:format)' => 'achievements#edit'
  put    'achievements/:project_slug/:slug(.:format)'      => 'achievements#update'
  delete 'achievements/:project_slug/:slug(.:format)'      => 'achievements#destroy'

  get  'user-achievements/:user_id/:achievement_id(.:format)'              => 'user_achievements#get',       :defaults => {format: 'json'}
  post 'user-achievements/:user_id/:achievement_id/set(/:value)(.:format)' => 'user_achievements#set',       :defaults => {format: 'json'}
  post 'user-achievements/:user_id/:achievement_id/inc(/:value)(.:format)' => 'user_achievements#increment', :defaults => {format: 'json', value: 1}
end
