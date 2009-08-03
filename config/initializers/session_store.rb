# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :session_key => "_CHANGEME_session",
  :secret      => "29f5437d11e15cb8f4eb994c9d28202c261ea93f0fc9c4ecfc30830a1da39ab3a7ad834201785ea4fe266f5a598a7fd5965a4ec847e8a04a9fb1513729c3f817"
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
