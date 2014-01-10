Groupme::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  #devise_scope :user do
  #get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
  #get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  #end
  #root :to => 'high_voltage/pages#show', :id => 'welcome'
  root :to => "groups#index"
 

  	resources :groups do
  		member do
		post :join
		post :quit
		end
	    resources :posts
	end


  # faceboook login 
  #  devise_for :users, :controllers => {
  #							 :sessions      => "users/sessions",
  #							 :registrations => "users/registrations",
  #							 :passwords     => "users/passwords",
  #							 :omniauth_callbacks => "users/omniauth_callbacks" 
  # 					 	 }
end
