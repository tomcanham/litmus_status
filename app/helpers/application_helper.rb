module ApplicationHelper
  def status_to_class(status)
    if (!status || status.site_down == nil)
      "unknown"
    elsif status.site_down
      "down"
    else
      "up"
    end
  end

  def status_to_text(status)
    status_to_class(status).upcase
  end
end
