class SessionsController < ApplicationController
  def create
    token = auth_hash[:credentials][:token]
    render :text => token
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
