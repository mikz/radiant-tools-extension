module RadiantTools::ReverseBreadcrumbsTags
  def self.init
    Page.send :include, self
  end
  
  include Radiant::Taggable
  
  desc %{
    Renders a trail of breadcrumbs to the current page. The separator attribute
    specifies the HTML fragment that is inserted between each of the breadcrumbs. By
    default it is set to @>@. The boolean nolinks attribute can be specified to render
    breadcrumbs in plain text, without any links (useful when generating title tag).
    The boolean reverse attribute can be specified to render
    breadcrumbs in reverse order.

    *Usage:*

    <pre><code><r:breadcrumbs [separator="separator_string"] [nolinks="true"] [reverse="true"] /></code></pre>
  }
  tag 'breadcrumbs' do |tag|
    page = tag.locals.page
    breadcrumbs = [page.breadcrumb]
    nolinks = (tag.attr['nolinks'] == 'true')
    reverse = (tag.attr['reverse'] == 'true')
    
    page.ancestors.each do |ancestor|
      tag.locals.page = ancestor
      
      breadcrumb = nolinks ? tag.render('breadcrumb') : %{<a href="#{tag.render('url')}">#{tag.render('breadcrumb')}</a>}
      
      breadcrumbs.send( reverse ? :push : :unshift, breadcrumb )
    end
    
    separator = tag.attr['separator'] || ' &gt; '
    breadcrumbs.join(separator)
  end
end