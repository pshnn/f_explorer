# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  get '/explorer', to: 'explorer#explore'
end
