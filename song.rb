#!/usr/bin/ruby -w
# SONG
# Copyright Mark Keane, All Rights Reserved, 2014


# Class that encodes details of a song.
class Song
  include Pred
  attr_accessor :name, :album, :artist, :time, :owners, :id
  def initialize(name, album, artist, time, owners, id)
    @name = name
    @album = album
    @time = time
    @artist = artist
    @owners = owners
    @id = id
  end

  # Method that prints out the contents of a song object nicely.
  def to_s
    puts "<< #{@name} >> by #{@artist} in their album #{@album} is owed by #{@owners} .\n"
  end 

  # Method that plays a song (sort of ;-)
  def play_song
    no = rand(10)
    no.times {print "#{@name} do be do..."}
    puts "\n"
  end

  # Method that check wheahter a song has owner
  def check_owner
    self.owners
  end

end