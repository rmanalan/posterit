require 'rubygems'
require 'sinatra'
require 'haml'
require 'lib/posterous'

set :haml, {:format => :html5 }
set :environment, :production

get '/' do
  @params = params
  haml :index
end

post "/" do
  posterous = Posterous.new(params[:email], params[:password])
  @resp = posterous.newpost(params[:title], params[:body], params[:autopost])
  haml :posted
end
