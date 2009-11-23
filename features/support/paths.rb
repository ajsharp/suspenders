module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /the new user page/
      new_user_url
    when /the user login page/
      login_url
    when /the user dashboard page/
      dashboard_path
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
