# frozen_string_literal: true

# BreadcrumbsService
class BreadcrumbsService
  ROOT_DIR_PATH = ''
  ROOT_DIR_NAME = 'root'

  def initialize(params = {})
    @path = params.fetch :path, ROOT_DIR_PATH
    @result = []
  end

  def call
    build_breadcrumbs_from_path

    result
  end

  private

  attr_reader :path, :result

  def path_names
    @path_names ||= path.present? ? path.split('/') : [ROOT_DIR_PATH]
  end

  def build_breadcrumbs_from_path
    current_path = ROOT_DIR_PATH

    path_names.each_with_index do |value, idx|
      name = idx.zero? ? ROOT_DIR_NAME : value
      current_path += "/#{path_names[idx]}" unless idx.zero?

      result[idx] = { name: name, path: current_path }
    end
  end
end
