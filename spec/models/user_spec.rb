require 'spec_helper'

describe User do
  describe "can create user" do
    before do
      User.new()
    end

    it { should be_valid }
  end
end
