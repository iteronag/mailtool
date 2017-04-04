module EmailTemplatesHelper
require "html_truncator"

  #convert long text into short form
  def short_text_display content, path
    text = ((content.length > 90) ?  HTML_Truncator.truncate(content, 3) : content )
    ((content.length > text.length) ? (text + "<a href='#{path}' class='btn-link'> (more) </a>") : text).html_safe
  end
end

