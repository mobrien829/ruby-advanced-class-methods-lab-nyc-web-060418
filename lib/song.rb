require "pry"

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def initialize(name = "", artist_name = "")
    @name = name
    @artist_name = artist_name
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    @@all << Song.new
    return @@all.last
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    return song
  end

  def self.name
    @name
  end

  def self.artist_name
    @artist_name
  end

  def self.create_by_name(name)
    song = self.new
    song.name = name
    @@all << song
    song
  end

  def self.find_by_name(name)
    @@all.detect do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      return self.find_by_name(name)
    else
      self.create_by_name(name)
    end
  end

  def self.alphabetical
    @@all.sort {|a, b| a.name <=> b.name}
  end

  def self.new_from_filename(filename)
    song_data = filename.split(" - ")
    @artist_name = song_data[0]
    song = self.new_by_name(song_data[1].chomp(".mp3"))
    song.artist_name = self.artist_name
    song
  end

  def self.create_from_filename(filename)
    song_data = filename.split(" - ")
    @artist_name = song_data[0]
    song = self.create_by_name(song_data[1].chomp(".mp3"))
    song.artist_name = self.artist_name
  end

  def self.destroy_all
    @@all.clear
  end
end
