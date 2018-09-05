# frozen_string_literal: true

# ExplorerController
class ExplorerController < ApplicationController
  def explore
    render_explore
  end

  def destroy_file
    explorer.destroy params[:path]
    redirect_to explorer_path
  end

  private

  def render_explore
    render :explore, locals: { files: explorer.explore(params[:path]) }
  end

  def explorer
    @explorer ||= Explorer.new(client: client)
  end
end
