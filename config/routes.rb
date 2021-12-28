Rails.application.routes.draw do
  resources :messages
  resources :chats
  resources :system_applications

  scope '/admin' do
    mount Sidekiq::Web => "sidekiq", as: "sidekiq"
    mount RailsPerformance::Engine, at: "site_performance", as: "site_performance"
  end
end
