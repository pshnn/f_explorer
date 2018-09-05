# frozen_string_literal: true

# Explorer
class Explorer
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
  end

  private

  attr_reader :client

  def open_path(path)
    client.list_folder path
  end

  DropBoxFolder = Struct.new(:name, :path, :type)
  DropBoxFile = Struct.new(:name, :path, :size, :client_modified, :server_modified, :type)

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
    DropBoxFolder.new(params['name'], params['path_lower'], params['.tag'])
  end

  def create_file(params)
    DropBoxFile.new(
      params['name'],
      params['path_lower'],
      params['size'],
      params['client_modified'],
      params['client_modified'],
      params['.tag']
    )
  end
end
