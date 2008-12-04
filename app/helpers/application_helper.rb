# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def menu_sidebar
    MenuSidebar.load_from_yaml(File.join(RAILS_ROOT, 'config', 'menu.yml'))
  end
end
