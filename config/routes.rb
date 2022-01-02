Rails.application.routes.draw do
  resources :applications, :controller => "system_applications" do
    resources :chats do
      resources :messages
    end
  end

  scope "/admin" do
    mount Sidekiq::Web => "sidekiq", as: "sidekiq"
    mount RailsPerformance::Engine, at: "site_performance", as: "site_performance"
  end

  # direct :homepage do
  #   'https://www.postman.com/collections/6ed2730407949c6a8158'
  # end
  root to: 'application#root'
end
