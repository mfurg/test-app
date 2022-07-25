Rails.application.routes.draw do
  devise_for :users,
              defaults: { format: :json },
              controllers: {
                  sessions: 'users/sessions',
                  registrations: 'users/registrations'
              }
  
  scope '/api' do
    resources :users do 
      collection do
        get :current
      end
    end
    resources :items
    resources :orders
  end
end
