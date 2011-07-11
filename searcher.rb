#!/usr/bin/env ruby
# coding: utf-8

require "rubygems"
require "bundler/setup"
Bundler.require :default
require "pp"
require "time"

require_relative "./date_helper"
include ActionView::Helpers::DateHelper

lat, lng, radius = ARGV[0], ARGV[1], ARGV[2] || "50mi"
search = Twitter::Search.new
search = search.geocode(lat.to_f, lng.to_f, "50mi").per_page(100).retweets

populars = Hash.new {|h, k| h[k] = []}
search.each do |result|
  result.text.scan( /(?<=\W)#\w+\b/i ).each do |hashtag|
    populars[hashtag] << result
  end
end

tags = populars.reject {|key, array| array.length < 2}.map {|key, array| [key, array.length]}.sort_by(&:last).reverse
tags.each do |hashtag, count|
  puts "#{hashtag} (#{populars[hashtag].length})"
  data = populars[hashtag].map do |result|
    puts "  #{result.text} (by @#{result.from_user}, #{time_ago_in_words(Time.parse(result.created_at))})"
  end
  puts
end
