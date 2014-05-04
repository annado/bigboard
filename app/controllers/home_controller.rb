class HomeController < ApplicationController
  def index
    @client_id = Rails.application.secrets.yammer_api_key
  end
end
