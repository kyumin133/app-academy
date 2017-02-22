require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @name = "_rails_lite_app"
    @cookie = req.cookies[@name].nil? ? {} : JSON.parse(req.cookies[@name])
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie(@name, path: "/", value: JSON.generate(@cookie))
  end
end
