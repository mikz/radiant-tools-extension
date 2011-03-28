module RadiantTools::EnforceAdmin
  def self.init
    [Admin::ResourceController, Admin::ConfigurationController].each do |klass|
      klass.class_eval do
        prepend_before_filter :enforce_admin!
      
        protected
        def enforce_admin!
          return redirect_to logout_url unless current_user && current_user.admin?
        end
      end
    end
  end
end