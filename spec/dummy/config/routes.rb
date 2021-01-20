Rails.application.routes.draw do
  mount Stalker::Engine => "/_ah/health"
end
