# frozen_string_literal: true

# Explorer
class Explorer
  class NotFoundError < StandardError; end

  def initialize(params = {})
    @client = params.fetch :client, nil
  end

  def explore(path)
    path = '' if path.nil?
    opened_path_content = open_path path
    build_structure opened_path_content
  end

  def destroy(path)
    client.delete path
  rescue DropboxApi::Errors::NotFoundError
    raise NotFoundError
  end

  private

  attr_reader :client

  def open_path(path)
    client.list_folder path
  end

  def build_structure(content)
    result = []
    content.entries.map(&:to_hash).each do |c|
      case c['.tag']
      when 'folder'
        result << create_folder(c)
      when 'file'
        result << create_file(c)
      end
    end
    result
  end

  def create_folder(params)
    DropboxFolder.new params
  end

  def create_file(params)
    DropboxFile.new params
  end
end
