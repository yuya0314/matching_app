Warden::Manager.after_set_user do |user, auth, opts|
    puts "after_set_user was called with user ID #{user.id}"
    scope = opts[:scope]
    auth.cookies.signed["#{scope}.id"] = user.id
  end
  
  Warden::Manager.before_logout do |_user, auth, opts|
    puts "before_logout was called"
    scope = opts[:scope]
    auth.cookies.signed["#{scope}.id"] = nil
  end
  