# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class RadiantToolsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/radiant_tools"
  
  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    #Radiant::Config["tools"] ||= "i18n_date reverse_breadcrumbs asset_helpers"
    
    RadiantTools.init(:all || Radiant::Config["tools"])
    # tab 'Content' do
    #   add_item "Radiant Tools", "/admin/radiant_tools", :after => "Pages"
    # end
  end
end
