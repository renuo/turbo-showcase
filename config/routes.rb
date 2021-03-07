Rails.application.routes.draw do
  root "home#show"

  get "/home/:action", to: "home#:action"
end
