# frozen_string_literal: true

# ExplorerController
module Explorer
  # Explorer::ExplorerFoldersController
  class ExplorerFoldersController < Explorer::ApplicationController
    Module.nesting

    def show
      render_show
    end

    def create_folder
      client.create_folder build_new_folder_path
      flash[:success] = "Folder '#{params[:folder_name]}' was created!"
      redirect_to explorer_path(path: path)
    rescue Explorer::WrongPath
      flash[:error] = 'Something went wrong...'
      redirect_to explorer_path(path: path)
    end

    private

    def build_new_folder_path
      "#{path}/#{params[:folder_name]}"
    end

    def render_show
      render(
        :show,
        locals: {
          files: files,
          breadcrumbs: breadcrumbs,
          path: path
        }
      )
    end

    def files
      if path.nil?
        opened_path_content = client.list_folder ''
      else
        opened_path_content = client.list_folder path
      end
      build_structure opened_path_content
    end

    def build_structure(content)
      result = []
      content.entries.map(&:to_hash).each do |c|
        case c['.tag']
        when 'folder'
          result << DropboxFolder.new(c)
        when 'file'
          result << DropboxFile.new(c)
        end
      end
      result
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
end
