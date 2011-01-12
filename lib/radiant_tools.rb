module RadiantTools
  def self.init modules
    case modules
    when String
      load_modules modules.split(/\s+/)
    when Array
      load_modules modules
    when :all
      load_modules all_modules
    else
      raise "Cannot process '#{modules.inspect}' (#{modules.class}) as list of modules to init."
    end
  end
  
  private
  def self.load_modules modules
    modules.each do |mod|
      (self.to_s.underscore + "/" + mod).camelize.constantize.init
    end
  end
  
  def self.all_modules(ext = "rb")
    Dir[File.join(File.dirname(__FILE__), "radiant_tools", "*.#{ext}")].map{|f| File.basename(f, ".#{ext}")}
  end
end