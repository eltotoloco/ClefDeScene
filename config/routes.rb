Rails.application.routes.draw do
  namespace :groupes do
    get 'steps_controller/show'
  end

  namespace :groupes do
    get 'steps_controller/update'
  end

  resources :demandes, only: [:new, :create, :update,:delete]
  root 'static_pages#home'
  get '/home' => "static_pages#home"

  get '/help' => "static_pages#help"

  get '/about' => "static_pages#about"
  get '/welcome' => "static_pages#welcome"
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

  resources :groupes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
