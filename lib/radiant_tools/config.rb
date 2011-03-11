module RadiantTools
  module Config
    def self.update(config)
      config.gem 'rack-rewrite'
    
      require 'rack-rewrite' unless defined?(Rack::Rewrite)

      config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
        r301 %r{^\/(.+?)(?:\/)(\?.+)$}, '/$1$2', :method => 'GET' # redirect action/?query to just action?query
        r301 %r{^\/([^?]+[^\/])$}, '/$1/', :method => 'GET', :not => /^\/admin\// # add trailing slash instead of removing it
      end
    
      config.gem "rack-cache"
      config.gem "redis-store"
      
      config.middleware.use ::Radiant::Cache,
        :metastore   => "redis://#{REDIS}/meta_store",
        :entitystore => "redis://#{REDIS}/entity_store",
        :verbose => true
      
      RedisRadiantStore.init
      
      config.cache_store = :redis_store, "redis://#{REDIS}/cache_store"
    end
  end
end