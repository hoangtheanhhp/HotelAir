Rails.application.routes.draw do

  resources :products
  resources :todo_lists
	root 'pages#home'

	devise_for :users,
							path: '',
							path_names: {sign_in: 'login', sign_out: 'signout', edit: 'profile', sign_up: 'registration'},
							controllers: { omniauth_callbacks: 'omniauth_callbacks' }

	resources :users, only: [:show] do
		member do
			post 'verify_phone_number' => 'users#verify_phone_number'
			patch '/update_phone_number' => 'users#update_phone_number'
		end
	end

	resources :rooms, except: [:edit] do
		member do
			get 'listing'
			get 'pricing'
			get 'description'
			get 'photo_upload'
			get 'amenities'
			get 'location'
			get 'preload'
			get 'preview'
		end
		resources :photos, only: [:create, :destroy]
		resources :reservations, only: [:create]
		resources :calendars
	end

	resources :guest_reviews, only: [:create, :destroy]
	resources :host_reviews, only: [:create, :destroy]

	get '/your_trips' => 'reservations#your_trips'
	get '/your_reservations' => 'reservations#your_reservations'

	get 'search' => 'pages#search'


	# ------ AirKong ------
	get 'dashboard' => 'dashboards#index'

	resources :reservations, only: [:approve, :decline] do
		member do
			post '/approve' => "reservations#approve"
			post '/decline' => "reservations#decline"
		end
	end

  get '/host_calendar' => 'calendars#host'












	# others
	resources :todo_lists
	resources :products
end
