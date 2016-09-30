#!/usr/bin/env ruby

require 'rubygems'
require 'sitemap_generator'
require 'mysql2'


# rake sitemap:install


# MySQL Connect
client = Mysql2::Client.new(:host     => "localhost",
                            :username => "root",
                            :password => "root",
                            :port     => "8889",
                            :database => "onlineclasssearch",
                            :socket   => "/Applications/MAMP/tmp/mysql/mysql.sock");


# Initialize Sitemap
SitemapGenerator::Sitemap.default_host = 'http://localhost/onlineclasssearch/'

# Add Static Pages to Sitemap
SitemapGenerator::Sitemap.create do
	add '/home', :changefreq => 'daily', :priority => 0.9
end


# Iterate DB Data + Generate sitemap entries
SitemapGenerator::Sitemap.create do
	client.query("SELECT * FROM `ypusa_course`").each do |row|
		thisUrl = '?terms=test' + row["name"]
		add thisUrl, :changefreq => 'daily', :priority => 0.9
		puts "Added: " + thisUrl
	end
end

# TODO: GENERATE SITEMAP / PRINT SITEMAP


# SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks


# go!