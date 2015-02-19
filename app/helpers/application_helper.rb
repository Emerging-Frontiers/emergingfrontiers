module ApplicationHelper
def active_tab_class(*paths)  
    active = false  
    paths.each { |path| active ||= current_page?(path) }  
    active ? 'active' : ''  
  end
end
