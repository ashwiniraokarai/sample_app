module ApplicationHelper
  def title_helper(page_title)
    base_title = "Ruby on rails tutorial sample app"
    full_title = page_title + " | " + base_title
    if page_title.empty?
      base_title
    else
      full_title
    end
  end
end
