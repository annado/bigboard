require 'spec_helper.rb'

describe SessionsController do
  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:yammer] = OmniAuth::AuthHash.new({
      :credentials => { :token => 12345 }
      })

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:yammer]
  end

  describe '#create' do
    it 'should get create' do
      get :create
      assert_response :success
    end
  end
end
