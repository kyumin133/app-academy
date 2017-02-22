require 'json'

class Flash
  attr_accessor :persist_cookie, :now_cookie

  def initialize(req)
    @name = "_rails_lite_app_flash"
    @storing_cookie = {}
    @expiring_cookie = req.cookies[@name].nil? ? {} : JSON.parse(req.cookies[@name])
  end

  def [](key)
    @storing_cookie[key.to_s] || @expiring_cookie[key.to_s]
  end

  def []=(key, val)
    @storing_cookie[key] = val
  end

  def now
    @expiring_cookie
  end
  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_flash(res)
    res.set_cookie(@name, path: "/", value: JSON.generate(@storing_cookie))
  end
end
