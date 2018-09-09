# frozen_string_literal: true

module Explorer
  # Explorer::ApplicationController
  class ApplicationController < BaseController
    Module.nesting

    layout 'application'

    private

    def current_user
      @current_user ||= client.get_current_account
    end

    def client
      @client ||= DropboxApi::Client.new
    end
  end
end
