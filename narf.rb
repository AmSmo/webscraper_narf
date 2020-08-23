require 'nokogiri'
require 'pry'
require 'httparty'

class Episode
    attr_reader :parsed_episode
    def initialize(url)
        @url = HTTParty.get(url)
        @parsed_episode = parse_page
    end

    def get_text(css)
        css.map {|ele| ele.text.strip}
    end

    def parse_page
        return Nokogiri::HTML(@url)
    end

    def title
        get_text(parsed_episode.css('h1'))[0]
    end

    def airdate
        get_text(parsed_episode.css("[title^='See more']"))[0]
    end

    def rating
        get_text(parsed_episode.css('[itemprop="ratingValue"]'))[0]
    end

    def plot
        parsed_episode.at('.canwrap > p  > span').text.strip
    end

    def characters
        chars = parsed_episode.css('td.character').map {|char| char.text.strip}
        chars.map { |char| char.gsub(/[[:space:]]+/, " " ).strip}
    end

    def actors
        parsed_episode.css('.primary_photo > a  > img').map {|inner| inner.attributes["title"].value}
    end

    def cast_assesment
        i = 0
        cast = {}
        while i < actors.length
            cast[actors[i]] = characters[i].split(" / ")
            i+=1
        end
        
        cast
    end
end