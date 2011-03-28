module RadiantTools::RedisRadiantStore
  def self.init
    
    Rack::Cache::MetaStore.class_eval do
      def marshalable?(value)
        begin
          Marshal.dump(value)
        rescue TypeError
          false
        end
      end
      
      def persist_request(request)
        env = request.env.dup
        env.reject! { |key,val| (key =~ /[^0-9A-Z_]/) || !marshalable?(val) }
        env
      end
    end
    
    require 'redis-store' unless defined?(Rack::Cache::MetaStore::Redis)
    
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