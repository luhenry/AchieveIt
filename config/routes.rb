Achieveit::Application.routes.draw do
  resources :projects

  root to: 'homepage#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :developers, path: 'admin', controllers: {registrations: "developers/registrations", sessions: "developers/sessions"}

  resources :users

  resources :developer_projects

  resources :developers

  # get    'admin/projects(.:format)'            => 'projects#index'
  # get    'admin/projects/:slug(.:format)'      => 'projects#show'
  # get    'admin/projects/new(.:format)'        => 'projects#new'
  # post   'admin/projects(.:format)'            => 'projects#create'
  # get    'admin/projects/:slug/edit(.:format)' => 'projects#edit'
  # put    'admin/projects/:slug(.:format)'      => 'projects#update'
  # delete 'admin/projects/:slug(.:format)'      => 'projects#destroy'

  get    'admin/steps/:project_slug/:achievement_slug(.:format)'            => 'achievement_steps#index'
  get    'admin/steps/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#show'
  get    'admin/steps/:project_slug/:achievement_slug/new(.:format)'        => 'achievement_steps#new'
  post   'admin/steps/:project_slug/:achievement_slug(.:format)'            => 'achievement_steps#create'
  get    'admin/steps/:project_slug/:achievement_slug/:slug/edit(.:format)' => 'achievement_steps#edit'
  put    'admin/steps/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#update'
  delete 'admin/steps/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#destroy'

  get    'admin/levels/:project_slug/:achievement_slug(.:format)'            => 'achievement_steps#index'
  get    'admin/levels/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#show'
  get    'admin/levels/:project_slug/:achievement_slug/new(.:format)'        => 'achievement_steps#new'
  post   'admin/levels/:project_slug/:achievement_slug(.:format)'            => 'achievement_steps#create'
  get    'admin/levels/:project_slug/:achievement_slug/:slug/edit(.:format)' => 'achievement_steps#edit'
  put    'admin/levels/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#update'
  delete 'admin/levels/:project_slug/:achievement_slug/:slug(.:format)'      => 'achievement_steps#destroy'

  get    'admin/achievements/:project_slug(.:format)'            => 'achievements#index'
  get    'admin/achievements/:project_slug/:slug(.:format)'      => 'achievements#show'
  get    'admin/achievements/:project_slug/new(.:format)'        => 'achievements#new'
  post   'admin/achievements/:project_slug(.:format)'            => 'achievements#create'
  get    'admin/achievements/:project_slug/:slug/edit(.:format)' => 'achievements#edit'
  put    'admin/achievements/:project_slug/:slug(.:format)'      => 'achievements#update'
  delete 'admin/achievements/:project_slug/:slug(.:format)'      => 'achievements#destroy'

  get  'user-achievements/:user_id/:achievement_id(.:format)'              => 'user_achievements#get',       :defaults => {format: 'json'}
  post 'user-achievements/:user_id/:achievement_id/set(/:value)(.:format)' => 'user_achievements#set',       :defaults => {format: 'json'}
  post 'user-achievements/:user_id/:achievement_id/inc(/:value)(.:format)' => 'user_achievements#increment', :defaults => {format: 'json', value: 1}
end
