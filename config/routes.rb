TiRefdata::Engine.routes.draw do
  resources :countries, only: [:index, :show]
end
