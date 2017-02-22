require_relative "router"
require_relative "controller_base"
class Static
  def initialize(app)
    @app = app
  end

  def call(env)
    puts Dir.pwd
    req = Rack::Request.new(env)
    res = Rack::Response.new
    pattern = Regexp.new(/^\/public\/(.*)/)
    unless req.path =~ pattern
      res.status = 404
      return res
    else
      url = req.path[1..-1]
      begin
        res.write(File.read(url))
        # res.set_header("Content-type", "html/text")
        return res
      rescue
        Errno::ENOENT
        res.status = 404
        return res
      end
    end
  end
end
