ActionController::Routing::Routes.draw do |map|
  # ping url
  map.get 'ping', :controller => :ping, :action => :index
end