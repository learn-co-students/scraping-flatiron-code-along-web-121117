require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper


    def get_page
      doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    end

    def get_courses
      get_page.css(".post")
    end

    def make_courses
      get_courses.each do |course_xml_obj|
        new_course_obj = Course.new
        new_course_obj.title = course_xml_obj.css("h2").text
        new_course_obj.schedule = course_xml_obj.css("em").text
        new_course_obj.description = course_xml_obj.css("p").text
      end
    end


    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end


# Scraper.new.get_page
