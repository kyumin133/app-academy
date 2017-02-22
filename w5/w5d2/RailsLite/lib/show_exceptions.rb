require 'erb'

class ShowExceptions
  attr_reader :app
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue RuntimeError => e
      render_exception(e)
    end
  end

  private

  def render_exception(e)
    res = Rack::Response.new
    res.status = "500"
    res.add_header("Content-type", "text/html")
    res.write(e.to_s)
    # res[1] = {'Content-type' => 'text/html'}
    # res[2] = [e.to_s]
    [res.status, {'Content-type' => 'text/html'}, res.body]
  end

end
