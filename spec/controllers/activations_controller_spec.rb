require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivationsController do
  describe "GET new /activations/:token" do
    before :each do
      user = Factory.create(:user_waiting_activation)
      get :new, :activation_code => user.perishable_token
    end

    it { should render_template :new }
  end

  describe "POST create /activations" do
    context "successful" do
      before :each do
        user = Factory.create(:user_waiting_activation)
        post :create, :user => {:password => "homersimpson", :password_confirmation => "homersimpson"}, :id => user.id
      end

      it { should redirect_to(dashboard_url) }
    end

    context "unsuccessful" do
      before :each do
        user = Factory.create(:user_waiting_activation)
        post :create, :user => {:password => "homersimpson", :password_confirmation => "homer"}, :id => user.id
      end
      
      it { should render_template :new }
    end
  end

end
