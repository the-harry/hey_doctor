Rails.application.routes.draw do
  mount HeyDoctor::Engine, at: '/_ah/app_health'
end
