# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= client.get_current_account
  end

  def client
    @client ||= DropboxApi::Client.new
  end
end
