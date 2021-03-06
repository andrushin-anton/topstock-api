Rails.application.routes.draw do

  root 'home#index'

  #constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        get 'companies' => 'companies#index'
        get 'companies/:ticker' => 'companies#ticker'
        post 'companies/stats/:ticker' => 'companies#pull_stats'
      end
    end
  #end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
