module ApplicationHelper
  BASE_TITLE = "BIGBAG Store".freeze
  def full_title(page_title)
    if page_title.nil?
      raise "Page title is nil"
    elsif page_title.blank?
      BASE_TITLE
    else
      "#{page_title} - #{BASE_TITLE}"
    end
  end
end
