require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  describe "an existing user" do
    before(:each) do
      @user = Factory(:active_user)
    end
    
    it "should not require password to be passed in to update email" do
      @user.update_attributes(:email => "bart@bart.com").should == true
    end
    
    it "should be able to change his password" do
      @user.update_attributes(:password => "barney", :password_confirmation => "barney").should == true
    end
  
  end

  describe "when signing up a user" do
    before(:each) do
      @user = User.new :email => "foo@bar.com"
      @user.signup!.should == true
    end

    it "should be a pending user" do
      @user.state.should == "pending"
    end
    
    it "should not be a mentor" do
      @user.should_not have_role("admin")
    end
    
    
  end

  describe User, "when activating a pending user" do
    before :each do
      @user = Factory(:user)
      @user.activate
    end

    it "should create a blank profile when activated" do
      @user.profile.should be_instance_of Profile
    end

    it "should be active" do
      @user.state.should == "active"
    end
  end
  
  describe "roles" do
    it "should have the admin role" do
      u = Factory.create :active_user
      Factory.create(:admin_role)
      u.add_role "admin"
      u.should have_role("admin")
    end
    
    it "should not add a role twice" do
      u = Factory.create :active_user
      Factory.create(:admin_role)
      u.add_role "admin"
      u.add_role "admin"
      u.roles.length.should == 1
    end
    
  end


    it "should reset the token when sending activation instructions emails" do
      user = Factory.create(:user_waiting_activation)
      Notifier.should_receive(:deliver_activation_instructions)
      old_token = user.perishable_token
      user.deliver_activation_instructions!
      user.perishable_token.should_not == old_token
    end
    
    it "should reset the token when sending activation confirmationemails" do
      user = Factory.create(:user_waiting_activation)
      Notifier.should_receive(:deliver_activation_confirmation)
      old_token = user.perishable_token
      user.deliver_activation_confirmation!
      user.perishable_token.should_not == old_token
    end
    
    it "should reset the token when sending password reset instructions emails" do
      user = Factory.create(:user_waiting_activation)
      Notifier.should_receive(:deliver_password_reset_instructions)
      old_token = user.perishable_token
      user.deliver_password_reset_instructions!
      user.perishable_token.should_not == old_token
    end
    
end

describe User, "#active?" do
  before :each do
    @user = Factory(:user)
  end

  it "should return false for a pending user" do
    @user.should_not be_active
  end

  it "should return true for an active user" do
    @user.activate!
    @user.should be_active
  end
end

describe User, "#update_and_activate!" do
  before :each do
    @user = Factory :user_waiting_activation
  end

  context "when passed valid passwords" do
    it "should set the user's state to active" do
      @user.update_and_activate!({ :password => "password", :password_confirmation => "password" }) 
      @user.should be_active
    end

    it "should update the user's password" do
      lambda { @user.update_and_activate!({ :password => "password", :password_confirmation => "password" }) }.should change(@user, :crypted_password)
    end
  end

  context "when passed bad passwords" do
    before :each do
      @params = { :password => "bad", :password_confirmation => "password" }
      @result = @user.update_and_activate!(@params)
    end

    it "should return false if passwords are no good" do
      @result.should == false
    end

    it "should not activate the user" do
      @user.should_not be_active
    end

    it "should return errors if the passwords are no good" do
      @user.errors.should_not be_empty
    end

    it "should have an error on :password" do
      @user.errors.on(:password).should_not be_blank
    end
  end

end

describe User, "factories" do
  describe "admin" do
    before :each do
      @user = Factory.build :admin
    end

    it "should validate" do
      @user.should be_valid
    end

    it "should save" do
      @user.save.should == true
    end

    it "should be an admin" do
      @user.save
      @user.should be_admin
    end
  end
end

describe User, "#has_role?" do
  context "an admin user" do
    before(:all) { @user = Factory.create :admin }
    after(:all)  { @user.destroy }

    it "should be an admin" do
      @user.should have_role "Admin"
      @user.should be_admin
    end

    it "should not be an owner" do
      @user.should_not have_role "Owner"
    end

    it "should have one role" do
      @user.should have(1).role
    end
  end

  context "a normal user" do
    before(:all) { @user = Factory.create :active_user }
    after(:all)  { @user.destroy }

    it "should not be an admin" do
      @user.should_not have_role "Admin"
      @user.should_not have_role "admin"
      @user.should_not be_admin
    end

    it "should not be an owner" do
      @user.should_not have_role "Owner"
    end

    it "should not have any roles" do
      @user.should_not have(:any).roles
    end
  end
end
