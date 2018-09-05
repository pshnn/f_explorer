# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def active_class(path = nil)
    current_page?(path) ? 'active' : ''
  end
end
