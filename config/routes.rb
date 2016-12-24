Rails.application.routes.draw do
  resources :demandes, only: [:new, :create, :update,:delete]
  get '/annonces/new' => "static_pages#annonce", as: :new_annonce

  resources :annonces, except: :new
  resources :groups, controller: 'annonces', type: 'Group' 
  resources :photographers, controller: 'annonces', type: 'Photographer' 
  
  root 'static_pages#home'
  get '/home' => "static_pages#home"

  get '/help' => "static_pages#help"

  get '/about' => "static_pages#about", as: :additional_infos
  get '/welcome' => "static_pages#welcome", as: :welcome
  devise_for :users, controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations',
   passwords: 'users/passwords',
   confirmations: 'confirmations'  },skip: [:sessions]
   as :user do
    get 'signin', to: 'users/sessions#new', as: :new_user_session
    post 'signin', to: 'users/sessions#create', as: :user_session
    delete 'signout', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  get '/monProfile'  => "profiles#show", as: :my_profile
  get '/monGroupe' => "groupes#edit", as: :my_groupe

#  get "/demandesU" => 'demandes#from_category', as: 'demandesU'

resources :groupes, only: [:new, :create, :show, :index] do
  resources :steps, only: [:show, :update], controller: 'groupes/steps'
end

  get '/catalogue' => "annonces#catalogue", as: :catalogue




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
