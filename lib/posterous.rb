require 'rubygems'
require 'httparty'

class Posterous
  include HTTParty
  base_uri 'posterous.com'

  def initialize(mail, password)
    self.class.basic_auth mail,password
  end

  def sites
    self.class.get('/api/getsites')
  end

  def newpost(title, body, autopost = 0)
    self.class.get('/api/newpost', {:query => 
                   {:title => title, :body => body, :autopost => autopost, :source => "Posterit", :sourceLink => "http://posterit.heroku.com"}})
  end
end
