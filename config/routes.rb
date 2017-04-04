EmailMarketing::Application.routes.draw do

  resources :uploads


  resources :opportunity_generators do
      collection { post :import }
      collection { get :new_import }
      collection { get :review }
      collection { post :review }
      collection { post :update_status }
  end


  resources :mail_id_definitions

  resources :email_templates do #, :path => "email_templates/:language"
    collection do
      get 'new/:language', :to => "email_templates#new", :as => 'new_language'
      get '/:language', :to => "email_templates#index", :as => 'language'
      get '/:id/edit/:language', :to => "email_templates#edit", :as => 'edit_language'
      get '/:id/:language', :to => "email_templates#show", :as => 'show_language'
    end
  end

  # resources :new_templates do #, :path => "email_templates/:language"
  #   collection do
  #     get 'new/:language', :to => "email_templates#new", :as => 'new_language'
  #     get '/:id', :to => "email_templates#show", :as => 'show_language'
  #     get '/:id/edit/:language', :to => "email_templates#edit", :as => 'edit_language'
  #   end
  # end

  # resources :reminder_templates do #, :path => "email_templates/:language"
  #   collection do
  #     get 'new/:language', :to => "email_templates#new", :as => 'new_language'
  #     get '/:id', :to => "email_templates#show", :as => 'show_language'
  #     get '/:id/edit/:language', :to => "email_templates#edit", :as => 'edit_language'
  #   end
  # end

  resources :groups do
    resources :email_templates, only: [:index]
  end

  root :to => "general#index"
  match "*email_templates" => redirect("/")
end
