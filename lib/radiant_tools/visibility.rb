module RadiantTools::Visibility
  def self.init
    Page.send :extend, self
  end
  
  def visible_to(reader)
    self.scoped
  end
end