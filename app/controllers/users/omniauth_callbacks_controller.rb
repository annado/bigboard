class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def yammer
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_yammer_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Yammer") if is_navigational_format?
    else
      session["devise.yammer_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  
end