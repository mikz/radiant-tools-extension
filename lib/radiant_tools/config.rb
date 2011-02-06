module RadiantTools::Config
  def self.update(config)
    config.gem 'rack-rewrite', :require => false
    
    config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
      #r301 %r{^\/(.+)\/(\?.*)?$}, '/$1$2'
      r301 %r{^\/(.*?)(?:\/)?(\?.*)?$}, '/$1/$2' # add trailing slash instead of removing it
    end
  end
end