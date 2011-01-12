require File.dirname(__FILE__) + '/../spec_helper'

describe 'RadiantTools::I18nTags' do
  dataset :pages
  
  describe 'ArchiveTitleTags' do
    # TODO: test
  end
  
  describe 'DateTags' do
    describe '<r:date i18n="true">' do
      it 'should render the correct format' do
        format = "%B %Y"
        tag = %{<r:date i18n="true" format="#{format}"/>}

        expected = I18n.l(Date.today, :format => format, :locale => I18n.default_locale)

        pages(:home).should render(tag).as(expected)
      end
    end 

    describe '<r:date>' do
      it 'should render the correct format' do
        format = "%B %Y"
        tag = %{<r:date format="#{format}"/>}

        expected = Date.today.strftime format

        pages(:home).should render(tag).as(expected)
      end
    end
  end
  
end