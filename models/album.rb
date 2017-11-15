require('pg')
require('pp')
require_relative('../db/sql_runner')
require_relative('artist')
require_relative('album')

class Album

  attr_reader :id, :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end


  def save
    sql = "INSERT INTO albums (title, genre, artist_id)
          VALUES ($1, $2, $3)
          RETURNING *"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map{|album| Album.new(album)}
  end

  def all_artists
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    return result.map{|artists| Artist.new(artists)}
  end

end
