Rails.application.routes.draw do
  root 'application#index'
  scope '/api' do
    resource :messages, only: [:create]
  end
end
