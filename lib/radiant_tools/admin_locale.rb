module RadiantTools::AdminLocale
  def self.init
    ApplicationController.class_eval do
      
      def set_user_locale_with_admin
        if params[:controller].starts_with? 'admin/'
          set_user_locale_without_admin
        else
          I18n.locale = I18n.default_locale
        end
      end
      
      alias_method_chain :set_user_locale, :admin
      
    end
  end
end