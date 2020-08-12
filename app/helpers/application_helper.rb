module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'SKILL SHOW MOVIES'
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
