Rails.application.routes.draw do


  root 'static_pages#home'
  get '/home' => "static_pages#home"
  get '/help' => "static_pages#help"
  get '/additional' => "users#additional", as: :additional_infos
  get '/welcome' => "static_pages#welcome", as: :welcome

  get '/annonces/new' => "static_pages#annonce", as: :new_annonce
  resources :annonces, except: :new
  resources :groups, controller: 'annonces', type: 'Group' 
  resources :photographers, controller: 'annonces', type: 'Photographer' 
  
  resources :preview, only: [:show]
  resources :messages
  resources :demandes, except: [:new]

  post '/demandes/new' => "demandes#new", as: :new_payment
  get '/accept' => "demandes#accept", as: :accept_demande
  get '/refuse' => "demandes#refuse", as: :refuse_demande


  devise_for :users, controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations',
   passwords: 'users/passwords',
   confirmations: 'confirmations'  },skip: [:sessions]
   as :user do
    get 'signin', to: 'users/sessions#new', as: :new_user_session
    post 'signin', to: 'users/sessions#create', as: :user_session
    delete 'signout', to: 'users/sessions#destroy', as: :destroy_user_session
    get 'dashboard/profil', to: 'users/registrations#edit', as: :my_profile
  end
 # get '/monProfile'  => "profiles#show", as: :my_profile
  #get '/monGroupe' => "groupes#edit", as: :my_groupe

  resources :previews

  resources :pictures,only: [:show] ,controller: 'previews', type: 'Picture' 
  resources :audios, only: [:show],controller: 'previews', type: 'Audio' 

  get '/dashboard' => "dashboards#show"
  get '/mesannonces'  => "annonces#my_annonces", as: :my_annonces
  get '/dashboard/info'  => "dashboards#annonces", as: :my_info


  get '/catalogue' => "annonces#catalogue", as: :catalogue
  get '/inbox' => "demandes#inbox", as: :inbox




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
