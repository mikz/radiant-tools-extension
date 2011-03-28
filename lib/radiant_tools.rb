module RadiantTools
  autoload :VERSION, "radiant_tools/version"
  
  def self.init modules
    init_modules case modules
    when String
      load_modules(modules.split(/\s+/))
    when Array
      load_modules(modules)
    when :all
      all_modules
    else
      raise "Cannot process '#{modules.inspect}' (#{modules.class}) as list of modules to init."
    end
  end
  
  private
  def self.load_modules modules
    modules.map{ |mod| (self.to_s.underscore + "/" + mod).camelize.constantize }
  end
  
  def self.init_modules modules
    modules.each &:init
  end
  
  def self.all_modules(ext = "rb")
    [AssetHelpersTags, I18nTags, ReverseBreadcrumbsTags, TagAttributes, Visibility, AdminLocale, EnforceAdmin].map
  end
end