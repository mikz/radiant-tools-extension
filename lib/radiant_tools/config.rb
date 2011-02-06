module RadiantTools::Config
  def self.update(config)
    config.gem 'rack-rewrite', :require => false
    
    config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
      r301 %r{^\/(.+?)(?:\/)(\?.+)$}, '/$1$2', :if => lambda { |env| env['REQUEST_METHOD'].to_sym == :GET } # redirect action/?query to just action?query
      r301 %r{^\/([^?]+[^\/])$}, '/$1/', :if => lambda { |env| env['REQUEST_METHOD'].to_sym == :GET } # add trailing slash instead of removing it
    end
  end
end