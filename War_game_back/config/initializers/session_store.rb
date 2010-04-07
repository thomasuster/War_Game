# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_War_game_back_session',
  :secret      => '2ea108e37713567b1233c667a5f6de09931ce66da70e7473c7326a1e4d7b69cbd555c29a8592e3234867d134c97e6a02041f31c3a1e665a2f022758cbd0d647d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
