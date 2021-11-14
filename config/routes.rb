Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/jobs'
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [Rails.env, ENV.fetch('SIDEKIQ_WEB_PASSWORD') { Rails.env }]
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :categories, only: [:index, :create]
      resources :products
    end
  end
end
