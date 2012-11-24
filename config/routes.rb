Achieveit::Application.routes.draw do
  resources :tests

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

  get    'projects(.:format)'       => 'projects#index',   :defaults => {format: 'json'}
  get    'projects/:slug(.:format)' => 'projects#show',    :defaults => {format: 'json'}
  post   'projects(.:format)'       => 'projects#create',  :defaults => {format: 'json'}
  put    'projects/:slug(.:format)' => 'projects#update',  :defaults => {format: 'json'}
  delete 'projects/:slug(.:format)' => 'projects#destroy', :defaults => {format: 'json'}

  get    'steps/:project_slug/:achievement_slug(.:format)'       => 'achievement_steps#index',   :defaults => {format: 'json'}
  get    'steps/:project_slug/:achievement_slug/:slug(.:format)' => 'achievement_steps#show',    :defaults => {format: 'json'}
  post   'steps/:project_slug/:achievement_slug(.:format)'       => 'achievement_steps#create',  :defaults => {format: 'json'}
  put    'steps/:project_slug/:achievement_slug/:slug(.:format)' => 'achievement_steps#update',  :defaults => {format: 'json'}
  delete 'steps/:project_slug/:achievement_slug/:slug(.:format)' => 'achievement_steps#destroy', :defaults => {format: 'json'}

  get    'levels/:project_slug/:achievement_slug(.:format)'       => 'achievement_steps#index',   :defaults => {format: 'json'}
  get    'levels/:project_slug/:achievement_slug/:slug(.:format)' => 'achievement_steps#show',    :defaults => {format: 'json'}
  post   'levels/:project_slug/:achievement_slug(.:format)'       => 'achievement_steps#create',  :defaults => {format: 'json'}
  put    'levels/:project_slug/:achievement_slug/:slug(.:format)' => 'achievement_steps#update',  :defaults => {format: 'json'}
  delete 'levels/:project_slug/:achievement_slug/:slug(.:format)' => 'achievement_steps#destroy', :defaults => {format: 'json'}

  get    'achievements/:project_slug(.:format)'       => 'achievements#index',   :defaults => {format: 'json'}
  get    'achievements/:project_slug/:slug(.:format)' => 'achievements#show',    :defaults => {format: 'json'}
  post   'achievements/:project_slug(.:format)'       => 'achievements#create',  :defaults => {format: 'json'}
  put    'achievements/:project_slug/:slug(.:format)' => 'achievements#update',  :defaults => {format: 'json'}
  delete 'achievements/:project_slug/:slug(.:format)' => 'achievements#destroy', :defaults => {format: 'json'}

  get  'user-achievements/:user_id/:achievement_id(.:format)'              => 'user_achievements#get',       :defaults => {format: 'json'}
  post 'user-achievements/:user_id/:achievement_id/set(/:value)(.:format)' => 'user_achievements#set',       :defaults => {format: 'json'}
  post 'user-achievements/:user_id/:achievement_id/inc(/:value)(.:format)' => 'user_achievements#increment', :defaults => {format: 'json', value: 1}
end
