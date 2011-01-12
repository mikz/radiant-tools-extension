# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class RadiantToolsExtension < Radiant::Extension
  version "0.1"
  description "Various tools (method, tags) for Radiant projects"
  url "http://github.com/mikz/radiant_tools"
  
  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    #Radiant::Config["tools"] ||= "i18n_date i18n_archive_title reverse_breadcrumbs asset_helpers"
    
    RadiantTools.init(Radiant::Config["tools"] || :all)
    # tab 'Content' do
    #   add_item "Radiant Tools", "/admin/radiant_tools", :after => "Pages"
    # end
  end
end
