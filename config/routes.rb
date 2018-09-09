# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  # get '/explorer', to: 'explorer#explore'
  post '/create-folder/', to: 'explorer#create_folder'
  delete '/delete_file', to: 'explorer#destroy_file'

  namespace :explorer do
    root 'explorer_folders#show', as: :explorer_root
  end
end
