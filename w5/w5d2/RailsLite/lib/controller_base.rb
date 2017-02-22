require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, params = {})
    @req = req
    @res = res
    params.each do |k, v|
      @req.update_param(k, v)
    end
    @params = @req.params
    @already_built_response = false
    session
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "already built response" if already_built_response?
    @res.set_header('location', url)
    @res.redirect(url, 302)
    @already_built_response = true
    @session.store_session(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "already built response" if already_built_response?
    @res.set_header('Content-Type', content_type)
    @res.write(content)
    @already_built_response = true
    @session.store_session(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    root_name = /(.*)Controller/.match(self.class.to_s)[1].downcase
    path = "views/#{root_name}_controller/#{template_name.to_s}.html.erb"
    content = ERB.new(File.read(path)).result(binding)
    render_content(content, "text/html")
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    if self.methods.include?(:protect_from_forgery)
      unless @req.request_method == "GET"
        check_authenticity_token
      else
      end
    end
    send(name)
    render(name) unless @already_built_response
  end

  def form_authenticity_token
    @token ||= @params["authenticity_token"]
    @token ||= SecureRandom::urlsafe_base64(16)
    @res.set_cookie("authenticity_token", path: "/", value: @token)
    @token
  end

  def check_authenticity_token
    @token ||= form_authenticity_token
    raise "Invalid authenticity token" if @req.cookies["authenticity_token"].nil?
    @res.set_cookie("authenticity_token", path: "/", value: @params["authenticity_token"])
    unless @req.cookies["authenticity_token"] == @params["authenticity_token"]
      raise "Invalid authenticity token"
    end
  end

  def self.protect_from_forgery
    define_method(:protect_from_forgery) do
      check_authenticity_token
    end
  end
end
