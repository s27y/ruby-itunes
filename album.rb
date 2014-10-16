#!/usr/bin/ruby -w
# ALBUM
# Copyright Mark Keane, All Rights Reserved, 2014

# Class that encodes details of an album.
class Album
  include Pred
	attr_accessor :name, :tracks, :length, :artist,:owners, :id
	def initialize(name, tracks, length, artist, owners)
		@name = name
		@tracks = tracks
		@length = length
		@artist = artist
    @owners = owners
		@id = name.object_id
	end

  # Method that prints out the contents of an album object nicely.
	def to_s
		puts "The album #{@name} by #{@artist}. #{@tracks} tracks #{@length} owned by #{@owners}\n"
	end	

  # Method makes an album object; just uses Album.new; really
  # just being a bit explicit and obvious.

	def self.make_album(name,tracks, length, artist, owners)
		Album.new(name, tracks, length, artist, owners)
	end

  # Class Method that builds albums from song object's contents.
  # It returns an array of album objects.  It calls another class method that
  # builds a single album, given the name of that album.

  def self.build_all(albums = [])
    album_names = []
  	$songs.each do |s|
  		album_names << s.album
  	end

    album_names.uniq!

    p album_names
    album_names.each {|al| albums << Album.build_an_album_called(al)}

    albums
  end

  # Class method that takes an album name, it finds all the sounds that are in that album
  # builds up arrays of the song-names (tracks), runtimes, artist names.  These all get used
  # to populate the various attributes of the album object.

  def self.build_an_album_called(album_name)
    length = 0.0
    songs,artists,owners = [], [], []
    songs = $songs.select {|s| s.album == album_name}

    songs.each do |s|
      length += s.time
      artists << s.artist
      owners << s.owners
    end
    artists.uniq!
    owners = owners.clean_up
    #(name, tracks, length, artist, owners)
    Album.new(album_name, songs.length, length, artists, owners)
  end

end
