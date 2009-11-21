When /^the user with email "(.+)" goes to his activation page$/ do |email|
  user = User.find_by_email email
  user.should be_instance_of User

  visit(register_url(user.perishable_token))
end

