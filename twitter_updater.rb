require 'open-uri'
require "twitter"

class TwitterUpdater
  TwitterMaxChars = 140
  PBLinkStart = "http://www.thepornboutique.com/index.php/component/content/article/"
  def initialize()
    Twitter.configure do |config|
      config.consumer_key = "KN6oa23jp53E7lxx1oX2w"
      config.consumer_secret = "MzdQ0bo1PT6f7PgqlpZjHI7h7QoEmG2oDT1Dyiw"
      config.oauth_token = "295686351-6OpjTJHQD0hQ7zQvadlcjguJ32bqoWfh7cIz1ISI"
      config.oauth_token_secret = "tg4SUmOxJQdfJXTLu56E3mQpZhPrFpWBHQKvOXJoyfI"
    end
    @client = Twitter::Client.new
  end
  
  def update()
    puts "uploading status on twitter: starting"
    
    lines = read_content_from_file()
    parsed_lines = parse_lines(lines)
    post(parsed_lines)
    
    puts "uploading status on twitter: done"
  end
  
  def read_content_from_file()
    File.open("C:/content.csv").readlines
  end
  
  def parse_lines(lines)
    p lines
    parsedlines = Array.new(lines.length)
    0.upto(lines.length-1) { |i|
      parsedlines[i] = {
        "id" => get_id(lines[i]),
        "title" => get_title(lines[i]),
        "time" => get_time(lines[i])
      }
    }
    parsedlines
  end
  
  def post(parsed_lines)
    parsed_lines.each  {|parsed_line|
      anUpdate = build_update(parsed_line)
      puts "uploading " + anUpdate
      @client.update anUpdate
    }
  end
  
  def build_update(parsed_line)
    init_tags = "#freeporn "
    short_link = create_short_link(parsed_line["id"])
    time_and_link = parsed_line["time"] + " "  + short_link
    last_index = TwitterMaxChars - time_and_link.length()  -5 - init_tags.length
    #making sure the update is equal or less than 140 chars while ensuring that time and link exist in the fit update
    init_tags + parsed_line["title"].slice(0..last_index) + " " + time_and_link
  end
  
  def create_short_link(id)
    link = PBLinkStart + id
    open('http://qr.cx/api/?longurl=' + link, "UserAgent" => "Ruby Script").read
  end
  
  def get_id(line)
    line.split(";")[0].delete('"')
  end
  
  def get_title(line)
    line.split(";")[1].delete('"')
  end
  
  def get_time(line)
    s = line.split(";")[4].to_s
    s.match(/\dh \d\d? min|5\d min/).to_s
  end
end