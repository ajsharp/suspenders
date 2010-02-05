class User < ActiveRecord::Base
  
  acts_as_authentic do |u|
    u.validates_length_of_password_field_options = {:minimum => 6, :on => :update, :if => :has_no_credentials? }
    u.validate_login_field false
  end

  state_machine :state, :initial => :pending do
    state :pending
    state :active

    before_transition :pending => :active do |user|
      user.profile = Profile.new
    end

    event :activate do
      transition :pending => :active
    end
  end

  has_one  :profile, :dependent => :destroy
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  
  #delegate :name, :to => :profile
  
  attr_accessible :email, :password, :password_confirmation
  
  # returns true if the user has the "admin" role, false if not.
  def admin?
    has_role?("admin")
  end

  # returns true if the specified role is associated with the user.
  #  
  #  user.has_role("admin")
  def has_role?(role_name)
    !!roles.find(:first, :conditions => { :name => role_name })
  end
  
  # Adds a role to the user by name
  #
  # user.add_role("mentor")
  def add_role(role)
    return if self.has_role?(role)
    self.roles << Role.find_by_name(role)
  end
  
  # User creation/activation
  # Sets the email and then creates the account in the database,
  # sending the activation.
  def signup!
    #self.email = params[:user][:email]
    save_without_session_maintenance
  end
  
  # Activates a user, sets their password, and 
  # creates a blank profile record associated
  # with the user.
  #def activate!(params)
  #  self.active = true
  #  self.password = params[:user][:password]
  #  self.password_confirmation = params[:user][:password_confirmation]
  #  save_and_create_profile
  #  self.save
  #end
  
  def update_and_activate!(params)
    self.password              = params[:password]
    self.password_confirmation = params[:password_confirmation]
    self.activate
  end

  # Returns true if the password field in the database is blank
  def has_no_credentials?
    self.pending? || self.crypted_password.blank?
  end

  # Email notifications
  
  # Resets the token and sends the password reset instructions via Notifier
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  # Resets the token and sends the activation instructions via Notifier
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  # Resets the token and sends the activation confirmatio via Notifier
  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end
 
  # Creates a blank profile, associates it with the user, 
  # and saves the user
  def save_and_create_profile
    self.profile = Profile.new
    self.save
  end
  
end
