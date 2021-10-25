Rails.application.routes.draw do
  root "home#show"

  get "/home/:action", to: "home#:action"
  post "/home/:action", to: "home#:action"

  get "/training", to: "training#show"
  get "/letters/:letter", to: "letters#show"
  get "/letters/:letter/slow", to: "letters#slow"
end
