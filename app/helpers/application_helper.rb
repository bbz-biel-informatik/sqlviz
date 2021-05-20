module ApplicationHelper
  def info(article)
    link_to '&#9432;'.html_safe, documentation_path(article), class: 'documentation', target: '_blank'
  end

  def legend(text, index = 0)
    letters = 'abcdefghijklmnopqrstuvwxyz'
    "<div class='ct-series-#{letters[index]} legend'>" +
      "<svg viewBox='0 0 100 6' xmlns='http://www.w3.org/2000/svg'>" +
        "<rect class='ct-line' width='1' height='1' x='2' y='3' />" +
        "<text class='label' x='6' y='5'>#{text}</text>" +
      "</svg>" +
    "</div>"
  end
end
