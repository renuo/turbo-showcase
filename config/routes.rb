Rails.application.routes.draw do
  root "home#show"

  get "/home/:action", to: "home#:action"
  get "/frames", to: "home#frames"
  get "/slow", to: "home#slow"
  get "/pagination", to: "home#pagination"
  get "/forms", to: "home#forms"
  get "/inline_fields", to: "home#inline_fields"
  get "/streams", to: "home#streams"
  post "/home/:action", to: "home#:action"

  get "/training", to: "training#show"
  get "/letters/:letter", to: "letters#show"
  get "/letters/:letter/slow", to: "letters#slow"
  get ":action", to: "home#:action"
end
