Rails.application.routes.draw do
  root 'application#index'
  scope '/api' do
    resource :messages, only: [:create]
    post 'sms', on: :collection
  end
end
