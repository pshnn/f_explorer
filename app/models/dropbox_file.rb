# frozen_string_literal: true

# DropboxFile
class DropboxFile
  attr_reader :name, :path, :type

  def initialize(params = {})
    @name = params.fetch 'name', nil
    @path = params.fetch 'path_lower', nil
    @filesize = params.fetch 'size', nil
    @client_last_modified = params.fetch 'client_modified', nil
    @server_last_modified = params.fetch 'server_modified', nil
    @type = params.fetch '.tag', nil
  end

  def last_modified
    client_last_modified.to_datetime.strftime '%c'
  end

  def size
    Filesize.new("#{filesize} B").pretty
  end

  private

  attr_reader :client_last_modified, :server_last_modified, :filesize
end
