require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivationsController do
  describe "GET new /activations/:token" do
    before :each do
      user = Factory.create(:user_waiting_activation)
      User.should_receive(:find_using_perishable_token).and_return(user)
      get :new, :activation_code => user.perishable_token
    end

    it { should render_template :new }
  end

  describe "POST create /activations" do
    context "successful" do
      before :each do
        user = Factory.create(:user_waiting_activation)
        User.should_receive(:find).and_return(user)
        user.should_receive(:update_and_activate!).and_return(true)
        post :create, :user => {:password => "homersimpson", :password_confirmation => "homersimpson"}, :id => user.id
      end

      it { should redirect_to(dashboard_url) }
    end

    context "unsuccessful" do
      before :each do
        @user = Factory.create(:user_waiting_activation)
        User.should_receive(:find).and_return(@user)
        @user.should_receive(:update_and_activate!).and_return(false)
        post :create, :user => {:password => "homersimpson", :password_confirmation => "homer"}, :id => @user.id
      end
      
      it { should render_template :new }

      it "should not activate the user" do
        @user.should_not be_active
      end
    end
  end

end
