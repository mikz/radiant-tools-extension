module RadiantTools::I18nTags::ArchiveTitleTags
  def self.init
    Page.descendants.each do |klass|
      next unless klass.included_modules.include?(ArchiveIndexTagsAndMethods)
      klass.send :include, self # override original title function
    end
  end

  include Radiant::Taggable

  tag "title" do |tag|
    setup_date_parts
    page = tag.locals.page
    unless @year.nil?
      I18n.l(Date.new((@year || 1).to_i, (@month || 1).to_i, (@day || 1).to_i), :format => page.title, :locale => I18n.default_locale)
    else
      page.title
    end
  end

end
