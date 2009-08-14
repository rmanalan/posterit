require 'rubygems'
require 'sinatra'
require 'haml'
require 'lib/posterous'

set :haml, {:format => :html5 }
set :raise_errors, false
set :show_exceptions, false

get '/' do
  @params = params
  haml :index
end

post "/" do
  posterous = Posterous.new(params[:email], params[:password])
  @resp = posterous.newpost(params)
  if @resp["rsp"]["stat"] == "ok"
    haml :posted
  else
    raise PosterousAPIError, @resp["rsp"]["err"]["msg"]
  end
end

class PosterousAPIError < StandardError; end

error PosterousAPIError do
  @msg = env["sinatra.error"].message
  @request = request
  haml :error
end

