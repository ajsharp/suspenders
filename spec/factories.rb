Factory.define :user do |u|
  u.email "user@example.com"
  u.password "password"
  u.password_confirmation "password"
end

Factory.define :admin, :parent => :user do |a|
  a.email "admin@example.com"
  a.roles {|factory| [factory.association(:admin_role)]}
  a.state "active"
end

Factory.define :active_user, :parent => :user do |u|
  u.state "active"
end


Factory.define :user_waiting_activation, :parent => :user do |u|
  u.state "pending"
  u.perishable_token  "abcd"
end

Factory.define :user_requesting_password, :parent=>:user do |u|
  u.perishable_token  "abcd"
end

Factory.define :role do |r|
  r.name "user"
end

Factory.define :admin_role, :parent => :role do |r|
  r.name "admin"
end


