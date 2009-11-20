module LoginHelper
  def login_as(user)
    activate_authlogic
    UserSession.create user
  end
end
