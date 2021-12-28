Rails.application.routes.draw do
  resources :applications, :controller => "system_applications" do
    resources :chats, except: %i[update] do
      resources :messages
    end
  end

  scope "/admin" do
    mount Sidekiq::Web => "sidekiq", as: "sidekiq"
    mount RailsPerformance::Engine, at: "site_performance", as: "site_performance"
  end
end
