module ApplicationHelper
  def info(article)
    link_to '&#9432;'.html_safe, documentation_path(article), class: 'documentation', target: '_blank'
  end
end
