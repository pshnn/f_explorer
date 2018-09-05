# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  get '/explorer', to: 'explorer#explore'
  delete '/delete_file', to: 'explorer#destroy_file'
end
