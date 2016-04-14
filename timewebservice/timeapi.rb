require 'rubygems'
require 'sinatra/base'
require 'chronic'
require 'date'
require 'time'
require 'active_support/all'
require 'cgi'
require 'json'

module TimeAPI
  ZoneOffset = {
    'A' => +1,
    'ADT' => -3,
    'AKDT' => -8,
    'AKST' => -9,
    'AST' => -4,
    'B' => +2,
    'BST' => +1,
    'C' => +3,
    'CDT' => -5,
    'CEDT' => +2,
    'CEST' => +2,
    'CET' => +1,
    'CST' => -6,
    'D' => +4,
    'E' => +5,
    'EDT' => -4,
    'EEDT' => +3,
    'EEST' => +3,
    'EET' => +2,
    'EST' => -5,
    'F' => +6,
    'G' => +7,
    'GMT' => 0,
    'H' => +8,
    'HADT' => -9,
    'HAST' => -10,
    'I' => +9,
    'IST' => +1,
    'K' => +10,
    'L' => +11,
    'M' => +12,
    'MDT' => -6,
    'MSD' => +4,
    'MSK' => +3,
    'MST' => -7,
    'N' => -1,
    'O' => -2,
    'P' => -3,
    'PDT' => -7,
    'PST' => -8,
    'Q' => -4,
    'R' => -5,
    'S' => -6,
    'T' => -7,
    'U' => -8,
    'UTC' => 0,
    'V' => -9,
    'W' => -10,
    'WEDT' => +1,
    'WEST' => +1,
    'WET' => 0,
    'X' => -11,
    'Y' => -12,
    'Z' => 0
  }
  
  class App < Sinatra::Base

    set :sessions, false
    set :run, false
    set :environment, ENV['RACK_ENV']
	set :port, 80
    
    def callback
      (request.params['callback'] || '').gsub(/[^a-zA-Z0-9_]/, '')
    end
	
    def prefers_json?
      (request.accept.first || '').downcase == 'application/json'
    end
  
    def json?
      prefers_json? \
        || /\.json$/.match((params[:zone] || '').downcase) \
        || /\.json$/.match((params[:time] || '').downcase)
    end
	
    def jsonp?
      json? && callback.present?
    end
	
    def format
      format = (request.params.select { |k,v| v.blank? }.first || [nil]).first \
        || request.params['format'] \
        || (jsonp? ? '%B %d, %Y %H:%M:%S GMT%z' : '')
      CGI.unescape(format).gsub('\\', '%')
    end
	    
    get '/' do
      erb :index
    end
    
    get '/favicon.ico' do
      ''
    end
    
    get '/:zone/?' do
	  #erb :index
      parse(params[:zone])
    end
    
    get '/:zone/:time/?' do
      parse(params[:zone], params[:time])
    end
  
    def parse(zone='UTC', time='now')
      zone = zone.gsub(/\.json$/, '').upcase
      offset = ZoneOffset[zone] || Integer(zone)
      time = time \
        .gsub(/\.json$/, '') \
        .gsub(/^at /, '') \
        .gsub(/(\d)h/, '\1 hours') \
        .gsub(/(\d)min/, '\1 minutes') \
        .gsub(/(\d)m/, '\1 minutes') \
        .gsub(/(\d)sec/, '\1 seconds') \
        .gsub(/(\d)s/, '\1 seconds')
      
      if prefers_json?
        response.headers['Content-Type'] = 'application/json'
      end
      
      Time.zone = offset
      Chronic.time_class = Time.zone
      time = Chronic.parse(time).to_datetime.to_s(format)
      time = json? ? { 'dateString' => time }.to_json : time
      time = jsonp? ? callback + '(' + time + ');' : time
    end
  end
end

class Time  
  def to_datetime
    # Convert seconds + microseconds into a fractional number of seconds
    seconds = sec + Rational(usec, 10**6)

    # Convert a UTC offset measured in minutes to one measured in a
    # fraction of a day.
    offset = Rational(utc_offset, 60 * 60 * 24)
    DateTime.new(year, month, day, hour, min, seconds, offset)
  end
end

class DateTime
  def to_datetime
    self
  end
  
  def to_s(format='')
    unless format.empty?
      strftime(format)
    else
      strftime
    end
  end
end