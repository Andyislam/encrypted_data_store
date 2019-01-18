Rails.application.routes.draw do
  resources :encrypted_strings, param: :token
  # delete '/encrypted_strings' => 'encrypted_strings#destroy'


  namespace :api do
    namespace :v1 do
      resources :data_encrypting_keys
      post '/data_encrypting_keys/rotate' => 'key_rotation#rotate'
      get '/data_encrypting_keys/rotate/status' => 'key_rotation#current_status'
    end
  end

end
