require 'cgi'
require 'json'

require 'fanfeedr/league'
require 'fanfeedr/event'

class Fanfeedr
  def initialize params, ssl = false
    @api_key = params[:api_key]
    @tier = params[:tier]
    @ssl = ssl
    @domain = "ffapi.fanfeedr.com"

    @base_uri = "http://#{@domain}/#{@tier}/api/"
  end

  def leagues
    request_json('get', 'leagues').map do |item|
      League.new(:id => item["id"], :name => item["name"])
    end
  end

  def events object
    case object.class.to_s.downcase.to_sym
    when :league
      request_json('get', "leagues/#{object.id}/events").map do |item|
        Event.new(:id => item["id"], :date => item["date"], :name => item["name"])
      end
    when :conference
      request_json('get', "conferences/#{object.id}/events").map do |item|
        Event.new(:id => item["id"], :date => item["date"], :name => item["name"])
      end
    when :division
      request_json('get', "divisions/#{object.id}/events").map do |item|
        Event.new(:id => item["id"], :date => item["date"], :name => item["name"])
      end
    when :team
      request_json('get', "teams/#{object.id}/events").map do |item|
        Event.new(:id => item["id"], :date => item["date"], :name => item["name"])
      end
    when :geo
      request_json('get', "geos/#{object.id}/events").map do |item|
        Event.new(:id => item["id"], :date => item["date"], :name => item["name"])
      end
    end
  end

  def boxscore event
    request_json('get', "events/#{event.id}/boxscore")
  end

  def ssl?
    @ssl
  end
  
  def http
    unless @http
      if ssl?
        require 'net/https'
        require 'openssl'

        @http = Net::HTTP.new(@domain, Net::HTTP.https_default_port)
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        @http.use_ssl = true
      else
        require 'net/http'

        @http = Net::HTTP.new(@domain)
      end
    end

    @http
  end

  def request(method, path, *args)
    headers = {
      "Accept" => "application/json",
      "Content-type" => "application/json"
    }

    http # trigger require of 'net/http'

    klass = Net::HTTP.const_get(method.to_s.capitalize)
    path << "?api_key=#{CGI.escape(@api_key)}"
    http.request(klass.new("#{@base_uri}#{path}", headers), *args)
  end

  def request_json(method, path, *args)
    response = request(method, path, *args)
    JSON::load(response.body)
  end
end
