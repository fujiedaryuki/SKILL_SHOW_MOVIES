module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if  admin 
                  'SKILL SHOW MOVIES(管理者）'
                else
                  'SKILL SHOW MOVIES'
                end

    page_title.empty? ? base_title : page_title + " | " + base_title
  end
  
  def active_if(path)
    path == controller_path ? 'active' : ''
  end

end
