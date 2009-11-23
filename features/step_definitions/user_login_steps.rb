Given /^a logged in active user exists with email: "(.+)"$/ do |email|
  user = Factory(:active_user, :email => email)
  
  visit   login_path
  fill_in "Email",    :with => user.email
  fill_in "Password", :with => user.password
  click_button "Log In"
  
  UserSession.find.user.should == user
end

