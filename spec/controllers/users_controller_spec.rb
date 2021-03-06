require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  integrate_views
  describe "get /new" do
    it "should display the signup form" do
      get :new
      response.should render_template("new")
    end
  end
  
  describe "When showing a profile" do
    
    before(:each) do
      @user = Factory.create(:active_user)
      get :show, :id => @user.id
    end
    
    it "should render the show template" do
      response.should render_template("show")
    end
  end

  describe "POST /create" do
    context "user is successfully created" do
      before :each do
        Notifier.should_receive(:deliver_activation_instructions)
        post :create, :user => { :email => "new@new.com" }
      end

      it { should respond_with :redirect }
      it { should redirect_to root_url }
    end

    context "error creating user" do
      before :each do
        @user = Factory.build :user
        User.should_receive(:new).and_return(@user)
        @user.should_receive(:save).and_return(false)

        post :create, :user => { :email => "new@new.com" }
      end

      it { should render_template :new }
      it { should_not respond_with :redirect }
    end
  
  end
  
  describe "when not logged in" do
    it "should not display the edit page" do
      @user = Factory.create(:active_user)
      get :edit, :id => @user.id
      response.should_not render_template(:edit)
    end
  end
  
  describe "when logged in as a user" do
    before(:each) do
      activate_authlogic
      @user = Factory.create(:active_user)
      UserSession.create @user
    end

    describe "GET edit /users/1" do
      before :each do
        User.should_receive(:find).and_return(@user)

        get :edit, :id => @user.id
      end

      it { should render_template :edit }
    end

    describe "when editing an existing account" do
      
      it "should not display the edit page for a different account" do
        another_user = Factory.create(:active_user, :email => "foo@example.com")
        get :edit, :id => another_user.id
        response.should redirect_to(dashboard_path)
      end
    end

    describe "PUT update /users/1" do
      before :each do
        User.should_receive(:find).and_return(@user)
      end

      context "a successful update" do
        before :each do
          @user.should_receive(:update_attributes).and_return(true)
          put :update, :id => @user.id, :user => { :login => "new_login" }
        end
        
        it { should redirect_to dashboard_url }
      end

      context "an unsuccessful update" do
        before :each do
          @user.should_receive(:update_attributes).and_return(false)
          put :update, :id => @user.id, :user => { :login => "new_login" }
        end

        it { should render_template :edit }

      end
    end
      
  end  
end
