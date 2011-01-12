require File.dirname(__FILE__) + '/../spec_helper'

describe 'RadiantTools::I18nTags' do
  dataset :pages
  
  describe 'AssetHelpersTags' do
    describe '<r:path_to name="libs/app.js">' do
      it 'should render the correct path' do
        path = "libs/app.js"
        tag = %{<r:path_to name="#{path}"/>}

        expected = "/javascripts/#{path}"

        pages(:home).should render(tag).as(expected)
      end
    end 
    
  end
end