module RadiantTools::I18nTags
  def self.init
    [DateTags, ArchiveTitleTags].each &:init
  end
end