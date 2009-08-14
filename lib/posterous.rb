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

  def newpost(options)
    if options[:autopost] = 1 || true
      autopost = 1
    else
      autopost = 0
    end
    if options[:source]
      body = <<-EOS
        <blockquote class="posterous_long_quote">Source: #{options[:source]}
          <a href="#{options[:link]}">#{options[:link]}</a>
        </blockquote>
        <div class="posterous_quote_citation">
          Posted from <a href="http://www.google.com/reader/view">Google Reader</a>
        </div>
        #{("<p>" + options[:comment] + "</p>") if options[:comment]}
      EOS
    elsif options[:link]
      body = <<-EOS
        <blockquote class="posterous_long_quote">
          <a href="#{options[:link]}">#{options[:title]}</a>
        </blockquote>
        <div class="posterous_quote_citation">
          Posted from <a href="http://www.google.com/reader/view">Google Reader</a>
        </div>
        #{("<p>" + options[:comment] + "</p>") if options[:comment]}
      EOS
    else
      body = options[:body]
    end
    self.class.get('/api/newpost', {:query => 
                   { :title => options[:title], :body => body, :autopost => autopost, 
                     :source => "Posterit", :sourceLink => "http://posterit.heroku.com"} })
  end
end
