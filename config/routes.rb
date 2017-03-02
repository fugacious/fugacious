
Rails.application.routes.draw do

	post 'm', to: 'messages#create', as: 'messages'
	get 'm/:token', to: 'messages#show', as: 'message'
	delete 'm/:token', to: 'messages#destroy', as: 'destroy_message'
  root to: 'messages#new'
	get '/about' => 'pages#about'
	get '/privacy' => 'pages#privacy'

  if ENV['RAILS_ENV'] == 'development'
    require 'sidekiq/web'

    mount Sidekiq::Web, at:'/sidekiq'
  end

end
