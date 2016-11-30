#! /usr/bin/env ruby
require 'net/http'
require 'nokogiri'

uri = URI "http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US"

xml = Net::HTTP.get(uri)

#p xml
prefix = "http://www.bing.com"

doc = Nokogiri::XML(xml)
date = doc.at_xpath('//images/image/startdate')
img_url = doc.at_xpath('//images/image/url')
url = prefix + img_url.content
output_filename = date.content + ".jpg"
 
system("cd images && wget #{url} -O #{output_filename} && cd ..")

pwd = `pwd`
img_uri = "#{pwd.strip!}/images/#{output_filename}"

#system("gsettings set org.gnome.desktop.background picture-uri file://#{img_uri}") if File.exist?(img_uri)
