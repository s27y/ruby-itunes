#!/usr/bin/ruby -w
# iTUNES
# Copyright Mark Keane, All Rights Reserved, 2014

#This is the top level
require 'csv'
require_relative 'predicate'
require_relative 'actor'
require_relative 'album'
require_relative 'song'
require_relative 'reader'
require_relative 'utilities'
require_relative 'error'
require_relative 'data'


#songs_file = ARGV[0]                  #for command line
#owners_file = ARGV[1]                 #for command line

reader = Reader.new
data = DataBit.new()
songs_file = 'songs.csv'             #in RubyMine
owners_file = 'owners.csv'           #in RubyMine

puts "\nProcessing Songs from file: #{songs_file}"
data.songs = reader.read_in_songs(songs_file)

puts "Processing Ownership from file: #{owners_file}"
data.hashes = reader.read_in_ownership(owners_file)

puts "Building all owners..."
data.actors = Actor.build_all(data)

puts "Updating songs with ownership details..."
data.songs.each{|song| song.owners = data.hashes[song.id]}

data.songs.each do |s|
  if s.check_owner == nil
    MyErr.new("csv_file_error",s,"song_no_owner_check_owner").do_it
    exit
  end
end

puts "Building All Albums..."
data.albums = Album.build_all(data)

# Given the name of a song and a person; let them buy the song
puts "\nMarkk buys The Cure..."
song1 = Util.fetch(data,"The Cure")
mark =   Util.fetch(data,"markk")
mark.to_s
song1.to_s
mark.buys_song(song1)
song1.to_s

# What songs does Markk own
puts "\nHow many songs does Markk own..."
p mark.what_songs_does_he_own(data).size

puts "\nPlay The Cure..."
song1.play_song

# Print out all songs
puts "\nPrinting full details of all songs..."
data.songs.each do |song| 
	puts song
  puts song.owners
end
puts "==========ALBUM==========="
data.albums.each {|a| puts a}

# Call it like this in the command line.
# markkean% ruby itunes.rb songs.csv owners.csv

