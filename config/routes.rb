Rails.application.routes.draw do
  root "home#show"

  get "/frames", to: "home#frames"
  get "/slow", to: "home#slow"
  get "/pagination", to: "home#pagination"
  get "/forms", to: "home#forms"
  get "/replace_update_me", to: "home#replace_update_me"
  get "/navigate_away", to: "home#navigate_away"
  get "/replace_external_frame", to: "home#replace_external_frame"
  get "/replace_form_frame", to: "home#replace_form_frame"
  get "/slow_frame", to: "home#slow_frame"
  get "/inline_fields", to: "home#inline_fields"
  post "/refresh_stream_title", to: "home#refresh_stream_title"
  post "/form_submission", to: "home#form_submission"
  get "/inline_form_submission", to: "home#inline_form_submission"
  get "/issues", to: "home#issues"
  get "/form_get_submission", to: "home#form_get_submission"
  post "/form_get_submission", to: "home#form_get_submission"

  get "/streams", to: "home#streams"

  get "/training", to: "training#show"
  get "/training/instructions", to: "training#instructions"
  get "/letters/:letter", to: "letters#show"
  get "/letters/:letter/slow", to: "letters#slow"
end
