Rails.application.routes.draw do

    devise_for :users
	root to:'home#index'
	resources :works

	get "/search",      to:"works#search"
  

	resources :works do 
		resources :comments
	end
end
