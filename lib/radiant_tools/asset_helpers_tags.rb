module RadiantTools::AssetHelpersTags
  def self.init
    Page.send :include, self
  end
  
  include Radiant::Taggable
  
  ALLOWED_HELPERS = %w{javascript stylesheet image name}
  
  desc %{
    *Usage:*

    <pre><code><r:path_to [javascript="app.js"] [stylesheet="style.css"]/></code></pre>
  }
  
  tag 'path_to' do |tag|
    unless tag.attr.length == 1
      raise "Wrong number of arguments. Accepts only ONE attribute."
    end
    unless ALLOWED_HELPERS.include? tag.attr.first.first
      raise "Wrong attibute. Accepts only #{ALLOWED_HELPERS.to_sentence}."
    end

    name, value = tag.attr.first

    if name.to_sym == :name
      name = case value
      when /\.css$/
        "stylesheet"
      when /\.js$/
        "javascript"
      end
    end
    
    response.template.send("path_to_#{name}".to_sym, value).inspect
  end
  
  desc %{
    *Usage:*
    <pre><code><r:stylesheet name="stylesheet.css" [media="print"]/></code></pre>
  }
  tag "stylesheet" do |tag|
    response.template.send :stylesheet_link_tag, tag.attr.delete("name"), tag.attr
  end
  
  desc %{
    *Usage:*
    <pre><code><r:javascript name="app.js" [async]/></code></pre>
  }
  tag "javascript" do |tag|
    response.template.send :javascript_include_tag, tag.attr.delete("name"), tag.attr
  end
  
end