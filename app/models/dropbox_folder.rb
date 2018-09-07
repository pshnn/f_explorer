# frozen_string_literal: true

# DropboxFile
class DropboxFolder
  attr_reader :name, :path, :type

  def initialize(params = {})
    @name = params.fetch 'name', nil
    @path = params.fetch 'path_lower', nil
    @type = params.fetch '.tag', nil
  end
end
