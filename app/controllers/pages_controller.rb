# frozen_string_literal: true

# PagesController
class PagesController < ApplicationController
  def home
    render :home, locals: { name: current_user.name.display_name }
  end
end
