module RadiantTools::I18nTags::DateTags
  def self.init
    Page.send :include, self
  end
  
  include Radiant::Taggable
  
  desc %{
    Renders the date based on the current page (by default when it was published or created).
    The format attribute uses the same formating codes used by the Ruby @strftime@ function, but its formatted by I18n library. By
    default it's set to @%A, %B %d, %Y@.  The @for@ attribute selects which date to render.  Valid
    options are @published_at@, @created_at@, @updated_at@, and @now@. @now@ will render the
    current date/time, regardless of the  page.

    *Usage:*

    <pre><code><r:date [format="%A, %B %d, %Y"] [for="published_at"] [i18n="true"]/></code></pre>
  }
  
  tag 'date' do |tag|
    page = tag.locals.page
    format = (tag.attr['format'] || '%A, %B %d, %Y')
    i18n = (tag.attr['i18n'] == "true")
    time_attr = tag.attr['for']
    
    date = if time_attr
      case
      when time_attr == 'now'
        Time.zone.now
      when ['published_at', 'created_at', 'updated_at'].include?(time_attr)
        page[time_attr]
      else
        raise TagError, "Invalid value for 'for' attribute."
      end
    else
      page.published_at || page.created_at
    end
    
    
    if i18n
      I18n.l date, :format => format, :locale => I18n.default_locale
    else #behave just like original tag
      date.strftime format
    end
  end

end