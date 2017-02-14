Rails.application.routes.draw do
  root 'static_pages#help'
  get '/home' => "static_pages#home"
  get '/help' => "static_pages#help"
  get '/additional' => "users#additional", as: :additional_infos
  get '/welcome' => "static_pages#welcome", as: :welcome

  get '/annonces/new' => "static_pages#annonce", as: :new_annonce

  get '/annonces/begin' => "annonces#begin", as: :start_new_annonce

  resources :annonces, except: :new
  resources :groups, controller: 'annonces', type: 'Group'
  resources :photographers, controller: 'annonces', type: 'Photographer' 
  resources :messages
  resources :charges
  get '/demandes/sent' => "demandes#mes_demandes", type:"sent" ,as: :demandes_sent
  get '/demandes/received' => "demandes#mes_demandes", type:"received", as: :demandes_received
  resources :demandes, except: [:new]

  post '/demandes/new' => "demandes#new", as: :new_booking
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
    get '/account', to: 'users/registrations#edit', as: :my_account
  end


  resources :profils
  get '/monProfile'  => "profils#my_profil", as: :my_profil
  #get '/monGroupe' => "groupes#edit", as: :my_groupe

  resources :previews

  resources :images,only: [:show] ,controller: 'previews', type: 'Image' 
  resources :audios, only: [:show],controller: 'previews', type: 'Audio' 

  get '/dashboard' => "dashboards#show"
  get '/mesannonces'  => "annonces#my_annonces", as: :my_annonces
  get '/info'  => "dashboards#annonces", as: :my_info


  get '/catalogue' => "annonces#catalogue", as: :catalogue





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
