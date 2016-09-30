#!/usr/bin/env ruby

require 'rubygems'
require 'sitemap_generator'
require 'mysql2'
require 'uri'

# USAGE:
# rake sitemap:refresh


# MySQL Connect
client = Mysql2::Client.new(:host     => "localhost",
                            :username => "root",
                            :password => "root",
                            :port     => "8889",
                            :database => "onlineclasssearch",
                            :socket   => "/Applications/MAMP/tmp/mysql/mysql.sock");

# Initialize Sitemap (Dev or Prod)
# SitemapGenerator::Sitemap.default_host = 'http://localhost/onlineclasssearch/'
SitemapGenerator::Sitemap.default_host = 'http://onlineclasssearch.com/'



# Iterate DB Data and create sitemap entities
SitemapGenerator::Sitemap.create do
	add '/home', :changefreq => 'daily', :priority => 0.9
	client.query("SELECT * FROM `ypusa_course`").each do |row|

		title = row["name"]
		query = '?terms=' + title

		encoded = URI.encode(query)
		add encoded, :changefreq => 'daily', :priority => 0.9
		puts "Added: " + encoded
	end
	client.query("SELECT * FROM `ypusa_university`").each do |row|

		title = row["name"]
		query = '?terms=' + title

		encoded = URI.encode(query)

		add encoded, :changefreq => 'daily', :priority => 0.9
		puts "Added: " + encoded
	end
end

# DOCUMENTATION:
# SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks


# COMMANDS
# rake sitemap:install
# rake sitemap:refresh
# rake sitemap:refresh


# Set the host name for URL creation
# SitemapGenerator::Sitemap.default_host = "http://www.example.com"

# SitemapGenerator::Sitemap.create do
# Put links creation logic here.
#
# The root path '/' and sitemap index file are added automatically for you.
# Links are added to the Sitemap in the order they are specified.
#
# Usage: add(path, options={})
#        (default options are used if you don't specify)
#
# Defaults: :priority => 0.5, :changefreq => 'weekly',
#           :lastmod => Time.now, :host => default_host
#
# Examples:
#
# Add '/articles'
#
#   add articles_path, :priority => 0.7, :changefreq => 'daily'
#
# Add all articles:
#
#   Article.find_each do |article|
#     add article_path(article), :lastmod => article.updated_at
#   end
