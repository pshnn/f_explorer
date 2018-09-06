# frozen_string_literal: true

# ExplorerController
class ExplorerController < ApplicationController
  def explore
    render_explore
  end

  def destroy_file
    explorer.destroy path
    redirect_to explorer_path
  end

  private

  def render_explore
    render(
      :explore,
      locals: {
        files: explorer.explore(path), breadcrumbs: breadcrumbs
      }
    )
  end

  def explorer
    @explorer ||= Explorer.new(client: client)
  end

  def breadcrumbs
    @breadcrumbs ||= BreadcrumbsService.new(path: path).call
  end

  def path
    @path ||= params[:path]
  end
end
