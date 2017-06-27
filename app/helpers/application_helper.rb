module ApplicationHelper
  def full_title page_title
    page_title.empty? ? t("rails") : (page_title + " | " + t("rails"))
  end
end
