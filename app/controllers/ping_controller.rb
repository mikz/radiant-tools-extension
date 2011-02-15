class PingController < ApplicationController
  no_login_required
  
  def index
    render :text => 'pong'
  end
end
  