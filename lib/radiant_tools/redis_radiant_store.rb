module RadiantTools::RedisRadiantStore
  def self.init
    [Rack::Cache::MetaStore::Redis, Rack::Cache::EntityStore::Redis].each do |klass|
      klass.class_eval do
        def initialize(server, options = {})
          @cache = ::Redis::Factory.create server
          store = self.class.parent.to_s.underscore.split("/").last.pluralize
          (Radiant::Cache.send store) << self
        end
        
        def clear(matcher='*')
          cache.keys(matcher).each { |key| cache.del key }
        end
      end
    end
    
  end
end