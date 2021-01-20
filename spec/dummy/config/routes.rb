Rails.application.routes.draw do
  mount Stalker::Engine => "/stalker"

  get '/_ah/health', to: 'health#check'
end
