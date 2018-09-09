# frozen_string_literal: true

# ExplorerController
class ExplorerController < ApplicationController
  def explore
    render_explore
  end

  def destroy_file
    explorer.destroy path
    render json: {
      success: true,
      payload: { path: path, filename: filename }
    }, status: 200
  rescue Explorer::NotFoundError
    render json: { success: false }, status: 422
  end

  def create_folder
    explorer.create_folder path: path, folder_name: params[:folder_name] 
    flash[:success] = "Folder '#{params[:folder_name]}' was created!"
    redirect_to explorer_path(path: path)
  rescue Explorer::WrongPathError
    flash[:error] = 'Something went wrong...'
    redirect_to explorer_path(path: path)
  end

  private

  def render_explore
    render(
      :explore,
      locals: {
        files: explorer.explore(path),
        breadcrumbs: breadcrumbs,
        path: path
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

  def filename
    path.split('/').last
  end
end
