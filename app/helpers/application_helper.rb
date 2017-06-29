module ApplicationHelper
  def full_title page_title
    rails = t "rails"
    page_title.empty? ? rails : (page_title + " | " + rails)
  end
end
